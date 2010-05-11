Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/9] Adds Python module for HDP record parsing/generation
Date: Tue, 11 May 2010 12:38:16 -0300
Message-Id: <1273592303-18234-2-git-send-email-epx@signove.com>
In-Reply-To: <1273592303-18234-1-git-send-email-epx@signove.com>
References: <1273592303-18234-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the HDP record generation part, from a
easy-to-use dictionary to record in XML format.
---
 test/hdp/hdp_record.py |  193 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 193 insertions(+), 0 deletions(-)
 create mode 100644 test/hdp/hdp_record.py

diff --git a/test/hdp/hdp_record.py b/test/hdp/hdp_record.py
new file mode 100644
index 0000000..d4d72d6
--- /dev/null
+++ b/test/hdp/hdp_record.py
@@ -0,0 +1,193 @@
+#!/usr/bin/env python
+
+# This module is a prototype implementation of HDP profile
+# conversion from a simple dictionary to/from the XML format
+# that BlueZ understands.
+
+import xml.dom.minidom
+import string
+
+
+class HDPRecordException(Exception):
+	pass
+
+
+def myuint(value):
+	if type(value) is not int:
+		try:
+			value = string.atoi(value, 0)
+		except (TypeError, ValueError):
+			raise HDPRecordException("Invalid uint: %s", value)
+	if value < 0:
+		raise HDPRecordException("Value must be non-negative: %d" \
+						% value)
+	return value
+
+
+def add_attr(doc, parent, attr, data):
+	if attr is not None:
+		child = doc.createElement("attribute")
+		child.setAttribute("id", "0x%04x" % myuint(attr))
+		parent.appendChild(child)
+		parent = child
+
+	if type(data) is list:
+		child = doc.createElement("sequence")
+		for item in data:
+			add_attr(doc, child, None, item)
+	else:
+		element_type, value = data
+		if element_type == 'uint8':
+			value = "0x%02x" % myuint(value)
+		elif element_type == 'uint16':
+			value = "0x%04x" % myuint(value)
+		elif element_type == 'uint32':
+			value = "0x%08x" % myuint(value)
+		elif element_type == 'uuid' and type(value) is int:
+			value = "0x%04x" % value
+		child = doc.createElement(element_type)
+		child.setAttribute("value", value)
+
+	parent.appendChild(child)
+
+
+def gen_xml(service):
+	if not service['features']:
+		raise HDPRecordException("No HDP features")
+
+	cpsm = service['mcap_control_psm']
+	dpsm = service['mcap_data_psm']
+
+	if cpsm < 0x1001 or cpsm > 0xffff:
+		raise HDPRecordException("Control PSM invalid")
+	if dpsm < 0x1001 or dpsm > 0xffff or dpsm == cpsm:
+		raise HDPRecordException("Data PSM invalid")
+
+	doc = xml.dom.minidom.Document()
+	record = doc.createElement("record")
+	doc.appendChild(record)
+
+	roles = {}
+	mcap_supported_procedures = 0x00
+
+	for mcap_procedures in service.get('mcap_procedures', []):
+		if mcap_procedures == 'csp':
+			mcap_supported_procedures |= 0x08
+		elif mcap_procedures == 'csp_master':
+			mcap_supported_procedures |= 0x10
+		elif mcap_procedures == 'reconnect_init':
+			mcap_supported_procedures |= 0x02
+		elif mcap_procedures == 'reconnect_accept':
+			mcap_supported_procedures |= 0x04
+		else:
+			raise HDPRecordException("Unknown MCAP procedure: %s" \
+					% mcap_procedures)
+
+	data_spec = service.get('data_spec', 0x01) # 0x01 == IEEE 10267
+
+	hdp_features = []
+	mdeps = {}
+	data_types = {}
+
+	for feature in service['features']:
+		mdep_id = feature['mdep_id']
+		data_type = feature['data_type']
+		description = feature.get('description', None)
+		s_role = feature['role']
+
+		if s_role == 'source':
+			roles[0x1401] = True
+			role = 0x00
+		elif s_role == 'sink':
+			roles[0x1402] = True
+			role = 0x01
+		else:
+			raise HDPRecordException("Unknown role: %s" \
+				% feature['role'])
+
+		if role != mdeps.get(mdep_id, role):
+			raise HDPRecordException("Reusing MDEP ID %d " \
+				"for different role" % mdep_id)
+		mdeps[mdep_id] = role
+
+		if data_type in data_types:
+			if role in data_types[data_type]:
+				raise HDPRecordException("Redundant role/type" \
+					" tuple: (%s, %d)" % \
+					(s_role, data_type))
+			data_types[data_type].append(role)
+		else:
+			data_types[data_type] = [ role ]
+
+		feature_record = [ \
+			('uint8', mdep_id),
+			('uint16', data_type),
+			('uint8', role),
+			]
+		if description:
+			feature_record.append(('text', description))
+
+		hdp_features.append(feature_record)
+
+	if "handle" in service:
+		add_attr(doc, record, 0x0000, ('uint32', service['handle']))
+
+	roles_sequence = [('uuid', k) for k in roles.keys()]
+	add_attr(doc, record, 0x0001, roles_sequence)
+
+	add_attr(doc, record, 0x0004,	# protocol descriptor list
+		[
+			[
+				('uuid', 0x0100), # L2CAP
+				('uint16', cpsm), # control channel
+			], [
+				('uuid', 0x001e),   # MCAP control channel
+				('uint16', 0x0100), # version
+			],
+		])
+
+	add_attr(doc, record, 0x0006, # language/encoding
+		[
+			('uint16', 0x656e),  # 'en' (ISO 639 lang. code)
+			('uint16', 0x006a),  # UTF-8 (IANA MIBE code)
+			('uint16', 0x0100),  # Natural language ID
+		])
+
+	add_attr(doc, record, 0x0009,
+		[
+			[
+				('uuid', 0x1400),   # HDP
+				('uint16', 0x0100), # HDP version
+			],
+		])
+
+	add_attr(doc, record, 0x000d,  # additional protocols
+		[
+			[
+				[
+					('uuid', 0x0100), # L2CAP
+					('uint16', dpsm), # data channel
+				], [
+					('uuid', 0x001f), # MCAP data channel
+				],
+			],
+		])
+
+	name = service.get('name', "")
+	if name:
+		add_attr(doc, record, 0x0100, ('text', name))
+
+	description = service.get('description', "")
+	if description:
+		add_attr(doc, record, 0x0101, ('text', description))
+
+	provider = service.get('provider', "")
+	if provider:
+		add_attr(doc, record, 0x0102, ('text', provider))
+
+	add_attr(doc, record, 0x0200, hdp_features) # HDP supported features
+
+	add_attr(doc, record, 0x0301, ('uint8', data_spec))
+	add_attr(doc, record, 0x0302, ('uint8', mcap_supported_procedures))
+
+	return doc.toprettyxml(encoding="UTF-8")
-- 
1.7.0.4

