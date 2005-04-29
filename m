Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: neoclust <neoclust@mandriva.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200504291344.56311.neoclust@mandriva.org>
Subject: [Bluez-users] Can't compile bluez-hcidump 1.20
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 29 Apr 2005 13:44:56 +0200

Hi,

when trying to compile it I obtain:


hci.c: In function `master_link_key_dump':
hci.c:630: error: `master_link_key_cp' undeclared (first use in this function)
hci.c:630: error: (Each undeclared identifier is reported only once
hci.c:630: error: for each function it appears in.)
hci.c:630: error: `cp' undeclared (first use in this function)
hci.c: In function `read_remote_ext_features_dump':
hci.c:638: error: `read_remote_ext_features_cp' undeclared (first use in this 
function)
hci.c:638: error: `cp' undeclared (first use in this function)
hci.c: In function `request_local_ext_features_dump':
hci.c:770: error: `read_local_ext_features_cp' undeclared (first use in this 
function)
hci.c:770: error: `cp' undeclared (first use in this function)
hci.c: In function `request_clock_dump':
hci.c:778: error: `read_clock_cp' undeclared (first use in this function)
hci.c:778: error: `cp' undeclared (first use in this function)
hci.c: In function `command_dump':
hci.c:827: error: `OCF_CREATE_CONN_CANCEL' undeclared (first use in this 
function)
hci.c:828: error: `OCF_REMOTE_NAME_REQ_CANCEL' undeclared (first use in this 
function)
hci.c:829: error: `OCF_ACCEPT_SYNC_CONN_REQ' undeclared (first use in this 
function)
hci.c:840: error: `OCF_REJECT_SYNC_CONN_REQ' undeclared (first use in this 
function)
hci.c:861: error: `OCF_READ_LMP_HANDLE' undeclared (first use in this 
function)
hci.c:862: error: `OCF_SETUP_SYNC_CONN' undeclared (first use in this 
function)
hci.c:865: error: `OCF_MASTER_LINK_KEY' undeclared (first use in this 
function)
hci.c:868: error: `OCF_READ_REMOTE_EXT_FEATURES' undeclared (first use in this 
function)
hci.c:938: error: `OCF_READ_LOCAL_EXT_FEATURES' undeclared (first use in this 
function)
hci.c:951: error: `OCF_READ_CLOCK' undeclared (first use in this function)
hci.c: In function `read_local_commands_dump':
hci.c:1205: error: `read_local_commands_rp' undeclared (first use in this 
function)
hci.c:1205: error: `rp' undeclared (first use in this function)
hci.c: In function `read_local_ext_features_dump':
hci.c:1255: error: `read_local_ext_features_rp' undeclared (first use in this 
function)
hci.c:1255: error: `rp' undeclared (first use in this function)
hci.c: In function `read_clock_dump':
hci.c:1343: error: `read_clock_rp' undeclared (first use in this function)
hci.c:1343: error: `rp' undeclared (first use in this function)
hci.c: In function `cmd_complete_dump':
hci.c:1378: error: `OCF_CREATE_CONN_CANCEL' undeclared (first use in this 
function)
hci.c:1379: error: `OCF_REMOTE_NAME_REQ_CANCEL' undeclared (first use in this 
function)
hci.c:1459: error: `OCF_READ_LOCAL_COMMANDS' undeclared (first use in this 
function)
hci.c:1465: error: `OCF_READ_LOCAL_EXT_FEATURES' undeclared (first use in this 
function)
hci.c:1492: error: `OCF_READ_CLOCK' undeclared (first use in this function)
hci.c: In function `hardware_error_dump':
hci.c:1521: error: `evt_hardware_error' undeclared (first use in this 
function)
hci.c:1521: error: `evt' undeclared (first use in this function)
hci.c: In function `master_link_key_complete_dump':
hci.c:1622: error: `evt_master_link_key_complete' undeclared (first use in 
this function)
hci.c:1622: error: `evt' undeclared (first use in this function)
hci.c: In function `max_slots_change_dump':
hci.c:1816: error: `evt_max_slots_change' undeclared (first use in this 
function)
hci.c:1816: error: `evt' undeclared (first use in this function)
hci.c: In function `data_buffer_overflow_dump':
hci.c:1824: error: `evt_data_buffer_overflow' undeclared (first use in this 
function)
hci.c:1824: error: `evt' undeclared (first use in this function)
hci.c: In function `pscan_rep_mode_change_dump':
hci.c:1869: error: `evt_pscan_rep_mode_change' undeclared (first use in this 
function)
hci.c:1869: error: `evt' undeclared (first use in this function)
hci.c: In function `flow_spec_complete_dump':
hci.c:1879: error: `evt_flow_spec_complete' undeclared (first use in this 
function)
hci.c:1879: error: `evt' undeclared (first use in this function)
hci.c: In function `inq_result_with_rssi_dump':
hci.c:1912: error: `INQUIRY_INFO_WITH_RSSI_AND_PSCAN_MODE_SIZE' undeclared 
(first use in this function)
hci.c:1914: error: `inquiry_info_with_rssi_and_pscan_mode' undeclared (first 
use in this function)
hci.c:1914: error: `info' undeclared (first use in this function)
hci.c: In function `read_remote_ext_features_complete_dump':
hci.c:1945: error: `evt_read_remote_ext_features_complete' undeclared (first 
use in this function)
hci.c:1945: error: `evt' undeclared (first use in this function)
hci.c: In function `sync_conn_complete_dump':
hci.c:1967: error: `evt_sync_conn_complete' undeclared (first use in this 
function)
hci.c:1967: error: `evt' undeclared (first use in this function)
hci.c: In function `sync_conn_changed_dump':
hci.c:1988: error: `evt_sync_conn_changed' undeclared (first use in this 
function)
hci.c:1988: error: `evt' undeclared (first use in this function)
hci.c: In function `event_dump':
hci.c:2043: error: `EVT_LOOPBACK_COMMAND' undeclared (first use in this 
function)
hci.c:2052: error: `EVT_HARDWARE_ERROR' undeclared (first use in this 
function)
hci.c:2055: error: `EVT_FLUSH_OCCURRED' undeclared (first use in this 
function)
hci.c:2078: error: `EVT_MASTER_LINK_KEY_COMPLETE' undeclared (first use in 
this function)
hci.c:2105: error: `EVT_RETURN_LINK_KEYS' undeclared (first use in this 
function)
hci.c:2115: error: `EVT_DATA_BUFFER_OVERFLOW' undeclared (first use in this 
function)
hci.c:2118: error: `EVT_MAX_SLOTS_CHANGE' undeclared (first use in this 
function)
hci.c:2127: error: `EVT_PSCAN_REP_MODE_CHANGE' undeclared (first use in this 
function)
hci.c:2130: error: `EVT_FLOW_SPEC_COMPLETE' undeclared (first use in this 
function)
hci.c:2136: error: `EVT_READ_REMOTE_EXT_FEATURES_COMPLETE' undeclared (first 
use in this function)
hci.c:2139: error: `EVT_SYNC_CONN_COMPLETE' undeclared (first use in this 
function)
hci.c:2142: error: `EVT_SYNC_CONN_CHANGED' undeclared (first use in this 
function)
make[2]: *** [hci.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory 
`/home/neoclust/rpm/BUILD/bluez-hcidump-1.20/parser'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/neoclust/rpm/BUILD/bluez-hcidump-1.20'
make: *** [all] Error 2



Any ideas ?


thanks in advance



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
