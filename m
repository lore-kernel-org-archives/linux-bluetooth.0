Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F209381B0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808082; cv=none; b=HRN252Nq6DIoKvaVOXjOVf+GN3v/iDgAvYnvoegYlsIIxAiWzw/i0RTh44x18LWC7lmihBvohS2zpjl9XYFmGP/sSGKf4MbDaz9w2c8lNBIzutfysA+hR2VdRIboPu77zLq6VQ4lX8w/pIydFuQOjCvFph8jgkiiC7hN2XsanuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808082; c=relaxed/simple;
	bh=wrHiILXMcoe4sMrWivwNHB8yyBFseVapDZnHiCSk3E0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IMiYy6W6MCzmC2mGMtr6lCBA8MYy9zrg7sLabH+lcUwBSjXIJcxNUs+Te1ai7lyrpyUg4EYy6HHHye/kKNTvliPs1cnr0x+yi5BGyssMqBGB0CmgVbY8Hi/tRUebZj5gDuQNDVIuM8nlOgnCA30exQ2uHMRzu9CSNkAqlkaRCVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AyANLuvT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PRauIba/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AyANLuvT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRauIba/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3JHNv3185891
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+iJgksoh5RG
	qDhwTEPeosFUpLXiicnngBiQG02qgn2s=; b=AyANLuvTGF3kL8Mbi7HKEkB1W17
	0a8dIyTYVzPatO4bBXZcyEBHIA5AIcEIB6wrLoPCny6ieXZfmoPHm04SS3dDxWzb
	zwEbiC+xkzuo642Cwi3x45YrYB1UdGGGI/MQiKfp0MoQPi/XwcORXej/QWmpqfCA
	62hNRwwg1LzhVLH42bnHTHVHgfvflfuws4QmtIpxaPYs/jNoKqL04k6+hT2P96vX
	CrAoqllwLax9Wwaj03mSvvX2NlEB0fHLyJACXs6ZwU77+GDtvX+oZbAbUIaK+JLn
	SShD1sWVzaNJ6qCOihbEdfcH/xoe1TwoHMDX8c6VxxzAu9C4Xu6BuzCP9Vw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egj4hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 05:21:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso3190354a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 22:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787808079; x=1788412879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+iJgksoh5RGqDhwTEPeosFUpLXiicnngBiQG02qgn2s=;
        b=PRauIba/78hO7Hv1amarRZk0LLYmLP4ifr5EFHKLUNneWpfsQL0A/7TAvISSOfvy36
         up1N3+dzbqOK8kuDONo1ofXPA3ciFk5PbPtadjoAd/uTiVBQwqbz7QjTxn0NmTk/ucPs
         UIjrjhcuCiHG6Ej98Fr1E55YhsAvpQ45y3akMdHa7Ov7KXSg0eGCIDKQCPh+fT2sN6hr
         p04C/e71l7apHMfoYpkAsZ0e3glw1b7Xd1a8zj0uujPVM7cKZlPSpVWRQI5NcRRtKBBH
         B1egTtJ+X2Wm/9P6Ocye3IIA7rnjbdqeTExZKsV5OxSoTyupu5jIERv89eBxY+mbGjOM
         kaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787808079; x=1788412879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+iJgksoh5RGqDhwTEPeosFUpLXiicnngBiQG02qgn2s=;
        b=jAVBOKyeHcREV1FQV3wASKXNv9zBEp8l1BrkeY7fvVyTYPVIshKvDPmgfiX79NDOzR
         Afk9xbs381Zoj41G9hu29joMyNi/3XZ9HX30svh3LY3lja0+v9f0K88hNViKpiZ985Ax
         iDlNKKReK4rTH14NjTRUMrFsW1cH2GCcluGJ4OyQO/VwwzVX3SqcxHUaUwYWbDmzUGgX
         j94voONecosaq0NWy+W4px+xmSh6e6SzXdNweTo3gRt39rcAzngItpZZ+8qozK+wVYQr
         PjnWzVgYMo9KdSiSlPctzfEsTk9q8oozUrKuneat2HFqrGpq021HCvIQYf6iJ3DYPgb6
         57mA==
X-Gm-Message-State: AFuF++kNZIaQ1RdN6/A1P5MDO5T9gN2lN+NHIUVoSbDP6kMJ/NwXv/RJ
	1YY3/AsNndF/FWaE6t3caTcxZD1QEq7lmPpMJPellhSET5HJ1zXKxuyKeSWjL2z8cL/KsYG/6Ng
	9CsOK2vfasRVKttHS2c6Yu//Cyuj3ATPQfRDl8UeoDWntfubn2upDTRn89F7p0h/zasRv7kAO9Q
	dNjdU=
X-Gm-Gg: AR+sD11OE2AxR9GacRN9DVr+hM1dg/dSQ5V3wUuEN1pHCwfhq0u2xJZX3ht1iliLF56
	JCY7bHNIlnvu/20GV7f+qcfLmfgx38sKYwOftp4c0R0yfL5CJwq0E6bNHlhse8IyZ9LieVHDi0Z
	Plo0VWWIRzq7y+r9c1BqhqrTZ89PTdIDaKuc3V/nNmnLKD9Sraho64wXZCJ4Bm//QL9JP2/ofmJ
	sjuMArJFAF20XG9Fm1hsn8uY1G0wqVRcg4MrP4lkd0KPmanzNdsRqsG0Uiw9Gdwl96h+YTFUrqP
	SQRFywcqEFvL1NmnukWvWjMrYXee7IirgfujzwM1EDijHjD0aKrtTqsNkwlqztE2xHyfg1f8Pfo
	mBXC0wlcVIK3o2D60XWQ0atJFO6UCog==
X-Received: by 2002:a17:90b:164b:b0:396:4729:43fa with SMTP id 98e67ed59e1d1-3966ce035d6mr23749144a91.0.1787808078865;
        Wed, 26 Aug 2026 22:21:18 -0700 (PDT)
X-Received: by 2002:a17:90b:164b:b0:396:4729:43fa with SMTP id 98e67ed59e1d1-3966ce035d6mr23749067a91.0.1787808078218;
        Wed, 26 Aug 2026 22:21:18 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a9035c06sm11903265c88.10.2026.08.26.22.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:21:17 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 7/7] test: Add Python Ranging Provider example
Date: Thu, 27 Aug 2026 10:50:34 +0530
Message-Id: <20260827052034.1374180-8-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oYhslLQZOC5BmmeRNSHcUce2AA2b3mmk
X-Proofpoint-ORIG-GUID: oYhslLQZOC5BmmeRNSHcUce2AA2b3mmk
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8fc950 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=fQ45OrJ3TOGEEpsXh3QA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0MiBTYWx0ZWRfX/d9I4CV2rsKt
 PMuq/AbnpVI7Ft6ONGozhDJn/8U9XJIh541uQThiS/4pWe4JCpvpiTqOJpH66HRA+yPTW3hzt+I
 r2iHkifRhvY1DQopIRjquFVJd2r6rQFXntw/de5VxYohIK0APBnLL3qrjfqXnCztl+QgQpiW1kG
 iqpsMUJEAi8QsMNlKxTgsYpPSfLTOktu5Cfau5eenp2YXWz7CnjOEcbRADN1jLExVy+b8cC4EzD
 Qz1poK9R3PHzhjm/rPvXP0MKSOKV5WKX3MFuFAkxlQvxYn8wh8jtH15LbZ+8CJZYGDrz7m3BIM5
 jCZ6jHbi9rgO8p46DlT1gDdSUYjSusilam3gePmrsZnJa8GNnd0AOYLUTTi7q5/PCDOib1jffEJ
 gfnwSNJPW4mDpej9BJo7KYMUPtQwgmBdhIyGAX394F9YbbsRCm4reyvAN17h2wXoO8vTEK03KiG
 jLnZXK5PUBzkRCCT6+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0MiBTYWx0ZWRfX2a1QijbXiaad
 l17cw9jHJzBcC2AyIHjftYrCw3nwc5DgwphYMv1k3XJJLZZuyxVQuPWPSXSmKGBo4zsUHLQQevC
 YnoNTb6GB4ZFt/I6EZz543fCDn4osPQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270042

This patch introduces test/example-ranging-provider which implements
a simple D-Bus client application for ranging profile.
---
 Makefile.tools                |   1 +
 test/example-ranging-provider | 222 ++++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100644 test/example-ranging-provider

diff --git a/Makefile.tools b/Makefile.tools
index b3ef4ae1c..4a59b6dee 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -559,6 +559,7 @@ test_scripts += test/bluezutils.py \
 		test/test-hfp test/opp-client test/ftp-client \
 		test/pbap-client test/map-client test/example-advertisement \
 		test/example-gatt-server test/example-gatt-client \
+		test/example-ranging-provider \
 		test/test-gatt-profile test/test-mesh test/agent.py
 
 if BTPCLIENT
diff --git a/test/example-ranging-provider b/test/example-ranging-provider
new file mode 100644
index 000000000..72edfca6f
--- /dev/null
+++ b/test/example-ranging-provider
@@ -0,0 +1,222 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+import dbus
+import dbus.exceptions
+import dbus.mainloop.glib
+import dbus.service
+
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
+
+mainloop = None
+app = None
+bus = None
+
+BLUEZ_SERVICE_NAME = 'org.bluez'
+DBUS_OM_IFACE =      'org.freedesktop.DBus.ObjectManager'
+DBUS_PROP_IFACE =    'org.freedesktop.DBus.Properties'
+
+RANGING_PROVIDER_MANAGER_IFACE = 'org.bluez.RangingProviderManager1'
+RANGING_PROVIDER_IFACE = 'org.bluez.RangingProvider1'
+RANGING_PROVIDER_PATH = '/org/bluez/hci0'
+
+CS_IFACE = 'org.bluez.ChannelSounding1'
+
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+    _dbus_error_name = 'org.freedesktop.DBus.Error.InvalidArgs'
+
+
+class Application(dbus.service.Object):
+    def __init__(self, bus):
+        self.path = RANGING_PROVIDER_PATH
+        self.rangings = {}
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def add_ranging(self, ranging):
+        self.rangings[ranging.dev_path] = ranging
+        self.InterfacesAdded(ranging.get_path(), ranging.get_properties())
+
+    def remove_ranging(self, ranging):
+        del self.rangings[ranging.dev_path]
+        self.InterfacesRemoved(ranging.get_path(), [RANGING_PROVIDER_IFACE])
+
+    def find_by_device(self, dev_path):
+        return self.rangings.get(dev_path)
+
+    @dbus.service.method(DBUS_OM_IFACE, out_signature='a{oa{sa{sv}}}')
+    def GetManagedObjects(self):
+        response = {}
+
+        for ranging in self.rangings.values():
+            response[ranging.get_path()] = ranging.get_properties()
+
+        return response
+
+    @dbus.service.signal(DBUS_OM_IFACE, signature='oa{sa{sv}}')
+    def InterfacesAdded(self, object_path, interfaces_and_properties):
+        return
+
+    @dbus.service.signal(DBUS_OM_IFACE, signature='oas')
+    def InterfacesRemoved(self, object_path, interfaces):
+        return
+
+
+class Ranging(dbus.service.Object):
+    """
+    org.bluez.RangingProvider1 interface implementation
+    """
+    def __init__(self, bus, dev_path):
+        dev = dev_path.rsplit('/', 1)[-1]
+        self.path = RANGING_PROVIDER_PATH + '/' + dev
+        self.dev_path = dev_path
+        self.bus = bus
+        self.millimeters = None
+        dbus.service.Object.__init__(self, bus, self.path)
+
+    def get_ranging_properties(self):
+        properties = {}
+        if self.millimeters is not None:
+            properties['Distance'] = dbus.UInt32(self.millimeters)
+        properties['Device'] = dbus.ObjectPath(self.dev_path)
+        return properties
+
+    def get_properties(self):
+        return { RANGING_PROVIDER_IFACE: self.get_ranging_properties() }
+
+    def get_path(self):
+        return dbus.ObjectPath(self.path)
+
+    def set_distance_millimeters(self, millimeters):
+        self.millimeters = millimeters
+        print('ranging %s Distance %d' %
+                (self.path, self.millimeters))
+        self.PropertiesChanged(
+                RANGING_PROVIDER_IFACE, self.get_ranging_properties(), [])
+
+    @dbus.service.method(DBUS_PROP_IFACE,
+                         in_signature='s',
+                         out_signature='a{sv}')
+    def GetAll(self, interface):
+        if interface != RANGING_PROVIDER_IFACE:
+            raise InvalidArgsException()
+
+        return self.get_properties()[RANGING_PROVIDER_IFACE]
+
+    @dbus.service.signal(DBUS_PROP_IFACE, signature='sa{sv}as')
+    def PropertiesChanged(self, interface, properties, invalidated):
+        return
+
+
+def procedure_data_cb(data, path, interface):
+    ranging = app.find_by_device(path)
+    if ranging is None:
+        ranging = Ranging(bus, path)
+        app.add_ranging(ranging)
+
+    # This example does not parse ProcedureData at all; it just reports a
+    # fixed 2 meters on every procedure to illustrate the RangingProvider
+    # wiring.
+    ranging.set_distance_millimeters(2000)
+
+
+def register_provider_cb():
+    print('Ranging Provider registered')
+
+
+def register_provider_error_cb(error):
+    print('Failed to register Ranging Provider: ' + str(error))
+    mainloop.quit()
+
+
+def find_manager(bus):
+    try:
+        remote_om = dbus.Interface(bus.get_object(BLUEZ_SERVICE_NAME, '/'),
+                                   DBUS_OM_IFACE)
+        objects = remote_om.GetManagedObjects()
+    except dbus.exceptions.DBusException as e:
+        print('Failed to reach bluetoothd: ' + str(e))
+        return None
+
+    for o, props in objects.items():
+        if RANGING_PROVIDER_MANAGER_IFACE in props.keys():
+            return o
+
+    return None
+
+
+def unregister_provider_cb():
+    print('Ranging Provider unregistered')
+    for ranging in list(app.rangings.values()):
+        app.remove_ranging(ranging)
+    mainloop.quit()
+
+
+def unregister_provider_error_cb(error):
+    print('Failed to unregister Ranging Provider: ' + str(error))
+
+
+def unregister_ranging_provider(ranging_provider_manager):
+    ranging_provider_manager.UnregisterRangingProvider(RANGING_PROVIDER_PATH,
+                                    reply_handler=unregister_provider_cb,
+                                    error_handler=unregister_provider_error_cb)
+
+
+def main():
+    """
+    Simulates an external Channel Sounding ranging daemon: it registers with
+    BlueZ as a Ranging Provider, then listens for ProcedureData signals from
+    every device exposing org.bluez.ChannelSounding1 and turns each completed
+    procedure into a Distance update on the matching
+    RangingProvider object.
+    """
+    global mainloop, bus, app
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    try:
+        bus = dbus.SystemBus()
+    except dbus.exceptions.DBusException as e:
+        print('Failed to connect to the system bus: ' + str(e))
+        return
+
+    manager_path = find_manager(bus)
+    if not manager_path:
+        print('RangingProviderManager interface not found')
+        return
+
+    print('RangingProviderManager path = ', manager_path)
+
+    ranging_provider_manager = dbus.Interface(
+            bus.get_object(BLUEZ_SERVICE_NAME, manager_path),
+            RANGING_PROVIDER_MANAGER_IFACE)
+
+    app = Application(bus)
+
+    bus.add_signal_receiver(procedure_data_cb, signal_name='ProcedureData',
+                            dbus_interface=CS_IFACE, path_keyword='path',
+                            interface_keyword='interface')
+
+    mainloop = GObject.MainLoop()
+
+    print('Registering Ranging Provider...')
+
+    ranging_provider_manager.RegisterRangingProvider(RANGING_PROVIDER_PATH,
+                                    reply_handler=register_provider_cb,
+                                    error_handler=register_provider_error_cb)
+
+    # Unregister the Ranging Provider after an arbitrary amount of time
+    GObject.timeout_add(
+            60000, unregister_ranging_provider, ranging_provider_manager)
+
+    mainloop.run()
+
+
+if __name__ == '__main__':
+    main()
-- 

