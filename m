Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510201310w7b09bd32i30961f75a21b4bb3@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7934_8032412.1129839043287"
Subject: [Bluez-devel] [D-BUS PATCH] HCI Errors
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 20 Oct 2005 18:10:43 -0200

------=_Part_7934_8032412.1129839043287
Content-Type: multipart/alternative;
	boundary="----=_Part_7935_11280165.1129839043287"

------=_Part_7935_11280165.1129839043287
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch makes possible create HCI D-Bus errors.

I removed the previous HCI errors code defined in "dbus.h", now I am
using the codes defined in the "hci.h" file.

In a near future it should be better move the error related functions
to another file or try implements internationalization.

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_7935_11280165.1129839043287
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
This patch makes possible create HCI D-Bus errors.<br>
<br>
I removed the previous HCI errors code defined in &quot;dbus.h&quot;, now I=
 am <br>
using the codes defined in the &quot;hci.h&quot; file.<br>
<br>
In a near future it should be better move the error related functions <br>
to another file or try implements internationalization.<br>
<br>
Regards,<br>
Claudio. <br clear=3D"all">-- <br>-----------------------------------------=
----------------<br>Claudio Takahasi<br>Nokia's Institute of Technology - I=
NdT<br><a href=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@ind=
t.org.br
</a><br>


------=_Part_7935_11280165.1129839043287--

------=_Part_7934_8032412.1129839043287
Content-Type: application/octet-stream; name=hci_error_01.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="hci_error_01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2005-10-19 16:48:36.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.h	2005-10-20 16:49:37.000000000 -0200
@@ -41,27 +41,6 @@
 
 #define ERROR_INTERFACE		BASE_INTERFACE ".Error"
 
-#define ERROR_UNKNOWN_HCI_COMMAND				0x01
-#define ERROR_UNKNOWN_CONNECTION_IDENTIFIER			0x02
-#define ERROR_HARDWARE_FAILURE					0x03
-#define ERROR_PAGE_TIMEOUT					0x04
-#define ERROR_AUTHENTICATION_FAILURE				0x05
-#define ERROR_PIN_OR_KEY_MISSING				0x06
-#define ERROR_MEMORY_CAPACITY_EXCEEDED				0x07
-#define ERROR_CONNECTION_TIMEOUT				0x08
-#define ERROR_CONNECTION_LIMIT_EXCEEDED				0x09
-#define ERROR_SYNCHRONOUS_CONNECTION_LIMIT_EXCEEDED		0x0a
-#define ERROR_ACL_CONNECTION_ALREADY_EXISTS			0x0b
-#define ERROR_COMMAND_DISALLOWED				0x0c
-#define ERROR_CONNECTION_REJECTED_DUE_TO_LIMITED_RESOURCES	0x0d
-#define ERROR_CONNECTION_REJECTED_DUE_TO_SECURITY_REASONS	0x0e
-#define ERROR_CONNECTION_REJECTED_DUE_TO_UNACCEPTABLE_BDADDR	0x0f
-#define ERROR_CONNECTION_ACCEPT_TIMEOUT_EXCEEDED		0x10
-#define ERROR_UNSUPPORTED_FEATURE_OR_PARAMETER_VALUE		0x11
-#define ERROR_INVALID_HCI_COMMAND_PARAMETERS			0x12
-#define ERROR_REMOTE_USER_TERMINATED_CONNECTION			0x13
-#define ERROR_REMOTE_DEVICE_TERMINATED_CONNECTION_DUE_TO	0x14
-
 #define DEFAULT_DEVICE_PATH_ID 		(0xFFFF)
 #define MANAGER_PATH_ID			(0xFFFE)
 #define DEVICE_PATH_ID			(0xFFFD)
--- bluez-utils-cvs.orig/hcid/dbus.c	2005-10-19 16:48:15.000000000 -0200
+++ bluez-utils-cvs-hcid/hcid/dbus.c	2005-10-20 16:52:31.000000000 -0200
@@ -113,7 +113,7 @@
 	const char *str;
 }bluez_error_t;
 
-static const bluez_error_t error_array[] = {
+static const bluez_error_t dbus_error_array[] = {
 	{ BLUEZ_EDBUS_UNKNOWN_METHOD,	"Method not found"		},
 	{ BLUEZ_EDBUS_WRONG_SIGNATURE,	"Wrong method signature"	},
 	{ BLUEZ_EDBUS_WRONG_PARAM,	"Invalid parameters"		},
@@ -121,9 +121,64 @@
 	{ BLUEZ_EDBUS_NO_MEM,		"No memory"			},
 	{ BLUEZ_EDBUS_CONN_NOT_FOUND,	"Connection not found"		},
 	{ BLUEZ_EDBUS_UNKNOWN_PATH,	"Device path is not registered"	},
-	{ 0,				NULL }
+	{ 0,				NULL 				}
 };
 
+static const bluez_error_t hci_error_array[] = {
+	{ HCI_UNKNOWN_COMMAND,			"Unknown HCI Command"						},
+	{ HCI_NO_CONNECTION,			"Unknown Connection Identifier"					},
+	{ HCI_HARDWARE_FAILURE,			"Hardware Failure"						},
+	{ HCI_PAGE_TIMEOUT,			"Page Timeout"							},
+	{ HCI_AUTHENTICATION_FAILURE,		"Authentication Failure"					},
+	{ HCI_PIN_OR_KEY_MISSING,		"PIN Missing"							},
+	{ HCI_MEMORY_FULL,			"Memory Capacity Exceeded"					},
+	{ HCI_CONNECTION_TIMEOUT,		"Connection Timeout"						},
+	{ HCI_MAX_NUMBER_OF_CONNECTIONS,	"Connection Limit Exceeded"					},
+	{ HCI_MAX_NUMBER_OF_SCO_CONNECTIONS,	"Synchronous Connection Limit To A Device Exceeded"		},
+	{ HCI_ACL_CONNECTION_EXISTS,		"ACL Connection Already Exists"					},
+	{ HCI_COMMAND_DISALLOWED,		"Command Disallowed"						},
+	{ HCI_REJECTED_LIMITED_RESOURCES,	"Connection Rejected due to Limited Resources"			},
+	{ HCI_REJECTED_SECURITY,		"Connection Rejected Due To Security Reasons"			},
+	{ HCI_REJECTED_PERSONAL,		"Connection Rejected due to Unacceptable BD_ADDR"		},
+	{ HCI_HOST_TIMEOUT,			"Connection Accept Timeout Exceeded"				},
+	{ HCI_UNSUPPORTED_FEATURE,		"Unsupported Feature or Parameter Value"			},
+	{ HCI_INVALID_PARAMETERS,		"Invalid HCI Command Parameters"				},
+	{ HCI_OE_USER_ENDED_CONNECTION,		"Remote User Terminated Connection"				},
+	{ HCI_OE_LOW_RESOURCES,			"Remote Device Terminated Connection due to Low Resources"	},
+	{ HCI_OE_POWER_OFF,			"Remote Device Terminated Connection due to Power Off"		},
+	{ HCI_CONNECTION_TERMINATED,		"Connection Terminated By Local Host"				},
+	{ HCI_REPEATED_ATTEMPTS,		"Repeated Attempts"						},
+	{ HCI_PAIRING_NOT_ALLOWED,		"Pairing Not Allowed"						},
+	{ HCI_UNKNOWN_LMP_PDU,			"Unknown LMP PDU"						},
+	{ HCI_UNSUPPORTED_REMOTE_FEATURE,	"Unsupported Remote Feature"					},
+	{ HCI_SCO_OFFSET_REJECTED,		"SCO Offset Rejected"						},
+	{ HCI_SCO_INTERVAL_REJECTED,		"SCO Interval Rejected"						},
+	{ HCI_AIR_MODE_REJECTED,		"SCO Air Mode Rejected"						},
+	{ HCI_INVALID_LMP_PARAMETERS,		"Invalid LMP Parameters"					},
+	{ HCI_UNSPECIFIED_ERROR,		"Unspecified Error"						},
+	{ HCI_UNSUPPORTED_LMP_PARAMETER_VALUE,	"Unsupported LMP Parameter Value"				},
+	{ HCI_ROLE_CHANGE_NOT_ALLOWED,		"Role Change Not Allowed"					},
+	{ HCI_LMP_RESPONSE_TIMEOUT,		"LMP Response Timeout"						},
+	{ HCI_LMP_ERROR_TRANSACTION_COLLISION,	"LMP Error Transaction Collision"				},
+	{ HCI_LMP_PDU_NOT_ALLOWED,		"LMP PDU Not Allowed"						},
+	{ HCI_ENCRYPTION_MODE_NOT_ACCEPTED,	"Encryption Mode Not Acceptable"				},
+	{ HCI_UNIT_LINK_KEY_USED,		"Link Key Can Not be Changed"					},
+	{ HCI_QOS_NOT_SUPPORTED,		"Requested QoS Not Supported"					},
+	{ HCI_INSTANT_PASSED,			"Instant Passed"						},
+	{ HCI_PAIRING_NOT_SUPPORTED,		"Pairing With Unit Key Not Supported"				},
+	{ HCI_TRANSACTION_COLLISION,		"Different Transaction Collision"				},
+	{ HCI_QOS_UNACCEPTABLE_PARAMETER,	"QoS Unacceptable Parameter"					},
+	{ HCI_QOS_REJECTED,			"QoS Rejected"							},
+	{ HCI_CLASSIFICATION_NOT_SUPPORTED,	"Channel Classification Not Supported"				},
+	{ HCI_INSUFFICIENT_SECURITY,		"Insufficient Security"						},
+	{ HCI_PARAMETER_OUT_OF_RANGE,		"Parameter Out Of Mandatory Range"				},
+	{ HCI_ROLE_SWITCH_PENDING,		"Role Switch Pending"						},
+	{ HCI_SLOT_VIOLATION,			"Reserved Slot Violation"					},
+	{ HCI_ROLE_SWITCH_FAILED,		"Role Switch Failed"						},
+	{ 0,					NULL								},
+};
+
+
 static const char *bluez_dbus_error_to_str(const uint32_t ecode) 
 {
 	const bluez_error_t *ptr;
@@ -136,7 +191,15 @@
 		return strerror(raw_code);
 	} else if (ecode & BLUEZ_EDBUS_OFFSET) { 
 		/* D-Bus error */
-		for (ptr = error_array; ptr->code; ptr++) {
+		for (ptr = dbus_error_array; ptr->code; ptr++) {
+			if (ptr->code == ecode) {
+				syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, ptr->str);
+				return ptr->str;
+			}
+		}
+	} else {
+		/* BLUEZ_EBT_OFFSET - Bluetooth HCI errors */
+		for (ptr = hci_error_array; ptr->code; ptr++) {
 			if (ptr->code == ecode) {
 				syslog(LOG_INFO, "%s - msg:%s", __PRETTY_FUNCTION__, ptr->str);
 				return ptr->str;

------=_Part_7934_8032412.1129839043287--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
