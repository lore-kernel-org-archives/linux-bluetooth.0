Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040224153816.2796.qmail@web20729.mail.yahoo.com>
From: Gigie Lertriniva <gigie_lertriniva@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] pb when retrieving service record attributes
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 24 Feb 2004 07:38:16 -0800 (PST)

Hi,

I'm trying to program a browser to discover all
Bluetooth devices and all services on the discovered
devices. To do this I wrote the Java code below.
I run the code on Linux, with the Impronto developer
kit and with a Bluetooth USB adapter. As a test, I try
to discover the services available on my PDA.
If I limit my list of attributes to 10 elements when I
"searchServices(attributes, uuidSet, btDevice, this)",
it works fine. My problem arises when I add only one
more attribute; then I have the following result:

Start device discovery (GIAC)...
-- Discovered device: POCKET_PC
Start service discovery...
...End of device discovery.
-- discovered service:
... End of service discovery.

It discovers a service but the serviceRecord[]
returned is empty.

I printed the "bluetooth.sd.attr.retrievable.max"
value, and it's 128 so only 11 attributes should be
OK. There's no duplicate in my attributes array. And
all my attribute IDs are valid (any 10 of them work).

On the JABWT mailing list, someone suggested the
following:
"the bluetooth.sd.attr.retrievable.max is usually not
realiable, the limitation maybe on BlueZ itself"

Did anyone had a similar problem?

Gigie



Here is the code:

import java.io.*;
import javax.bluetooth.*;
import java.util.*;

public class Explorator
implements DiscoveryListener
{
DiscoveryAgent da;

public static void main(String[] args) {
new Explorator();
}

Explorator() {

try {
LocalDevice ld = LocalDevice.getLocalDevice();

System.out.println("Start device discovery
(GIAC)...");
da = ld.getDiscoveryAgent();
da.startInquiry(DiscoveryAgent.GIAC, this);
} catch (BluetoothStateException x) {
System.err.println(x);
}

}

public void deviceDiscovered(RemoteDevice btDevice,
DeviceClass cod) {
System.out.print(" -- Discovered device: ");
try {
System.out.println(btDevice.getFriendlyName(true));
} catch (IOException x) {
System.err.println(x);
}

System.out.println(" Start service discovery...");

int[] attributes = new int[11];
attributes[0] = 0x0005;
attributes[1] = 0x0006;
attributes[2] = 0x0007;
//attributes[3] = 0x0008;
attributes[4] = 0x0009;
attributes[5] = 0x000A;
//attributes[6] = 0x000B;
attributes[7] = 0x000C;
attributes[8] = 0x0200;
attributes[9] = 0x0201;
attributes[3] = (0x0000 + 0x0100);
attributes[6] = (0x0001 + 0x0100);
attributes[10] = (0x0002 + 0x0100);

UUID[] uuidSet = new UUID[1];
uuidSet[0] = new UUID(0x0100);

try {
da.searchServices(attributes, uuidSet, btDevice,
this);
} catch (BluetoothStateException x) {
System.err.println(x);
}
}



public void inquiryCompleted(int discType) {
if (discType == INQUIRY_ERROR)
System.out.println("Error occured during device
discovery.");
if (discType == INQUIRY_TERMINATED)
System.out.println("Device discovery canceled by the
application.");
if (discType == INQUIRY_COMPLETED)
System.out.println("...End of device discovery.");
}

public void servicesDiscovered(int transID,
ServiceRecord[]
servRecord) {
System.out.println(" -- discovered service:");
for (int i = 0; i < servRecord.length; i++) {
ServiceRecord servRec = servRecord[i];
int[] availableAttrib = servRec.getAttributeIDs();
for (int j = 0; j < availableAttrib.length; j++) {
DataElement de =
servRec.getAttributeValue(availableAttrib[j]);
System.out.print(" ");
switch (availableAttrib[j]) {

case 0x0000 : {System.out.println("ServiceRecordHandle
" +
de.toString()); break; }

case 0x0001 : {
Enumeration liste = (Enumeration)(de.getValue());
while (liste.hasMoreElements()) {
UUID serviceClassID =
(UUID)(((DataElement)(liste.nextElement())).getValue());
if (serviceClassID.equals(new UUID(0X1000)))
System.out.println("ServiceDiscoveryServerServiceClassID");
else if (serviceClassID.equals(new UUID(0X1001)))
System.out.println("BrowseGroupDescriptorServiceClassID");
else if (serviceClassID.equals(new UUID(0x1002)))
System.out.println("PublicBrowseGroup");
else if (serviceClassID.equals(new UUID(0x1101)))
System.out.println("SerialPort");
else if (serviceClassID.equals(new UUID(0x1102)))
System.out.println("LANAccessUsingPPP");
else if (serviceClassID.equals(new UUID(0x1103)))
System.out.println("DialupNetworking");
else if (serviceClassID.equals(new UUID(0x1104)))
System.out.println("IrMCSync");
else if (serviceClassID.equals(new UUID(0x1105)))
System.out.println("OBEXObjectPush");
else if (serviceClassID.equals(new UUID(0x1106)))
System.out.println("OBEXFileTransfer");
else if (serviceClassID.equals(new UUID(0x1107)))
System.out.println("IrMCSyncCommand");
else if (serviceClassID.equals(new UUID(0x1108)))
System.out.println("Headset");
else if (serviceClassID.equals(new UUID(0x1109)))
System.out.println("CordlessTelephony");
else if (serviceClassID.equals(new UUID(0x110A)))
System.out.println("AudioSource");
else if (serviceClassID.equals(new UUID(0x110B)))
System.out.println("AudioSink");
else if (serviceClassID.equals(new UUID(0x110C)))
System.out.println("A/V_RemoteControlTarget");
else if (serviceClassID.equals(new UUID(0x110D)))
System.out.println("AdvancedAudioDistribution");
else if (serviceClassID.equals(new UUID(0x110E)))
System.out.println("A/V_RemoteControl");
else if (serviceClassID.equals(new UUID(0x110F)))
System.out.println("VideoConferencing");
else if (serviceClassID.equals(new UUID(0x1110)))
System.out.println("Intercom");
else if (serviceClassID.equals(new UUID(0x1111)))
System.out.println("Fax");
else if (serviceClassID.equals(new UUID(0x1112)))
System.out.println("HeadsetAudioGateway");
else if (serviceClassID.equals(new UUID(0x1113)))
System.out.println("WAP");
else if (serviceClassID.equals(new UUID(0x1114)))
System.out.println("WAP_CLIENT");
else if (serviceClassID.equals(new UUID(0x1115)))
System.out.println("PANU");
else if (serviceClassID.equals(new UUID(0x1116)))
System.out.println("NAP");
else if (serviceClassID.equals(new UUID(0x1117)))
System.out.println("GN");
else if (serviceClassID.equals(new UUID(0x1118)))
System.out.println("DirectPrinting");
else if (serviceClassID.equals(new UUID(0x1119)))
System.out.println("ReferencePrinting");
else if (serviceClassID.equals(new UUID(0x111A)))
System.out.println("Imaging");
else if (serviceClassID.equals(new UUID(0x111B)))
System.out.println("ImagingResponder");
else if (serviceClassID.equals(new UUID(0x111C)))
System.out.println("ImagingAutomaticArchive");
else if (serviceClassID.equals(new UUID(0x111D)))
System.out.println("ImagingReferencedObjects");
else if (serviceClassID.equals(new UUID(0x111E)))
System.out.println("Handsfree");
else if (serviceClassID.equals(new UUID(0x111F)))
System.out.println("HandsfreeAudioGateway");
else if (serviceClassID.equals(new UUID(0x1120)))
System.out.println("DirectPrintingReferenceObjectsService");
else if (serviceClassID.equals(new UUID(0x1121)))
System.out.println("ReflectedUI");
else if (serviceClassID.equals(new UUID(0x1122)))
System.out.println("BasicPrinting");
else if (serviceClassID.equals(new UUID(0x1123)))
System.out.println("PrintingStatus");
else if (serviceClassID.equals(new UUID(0x1124)))
System.out.println("HumanInterfaceDeviceService");
else if (serviceClassID.equals(new UUID(0x1125)))
System.out.println("HardcopyCableReplacement");
else if (serviceClassID.equals(new UUID(0x1126)))
System.out.println("HCR_Print");
else if (serviceClassID.equals(new UUID(0x1127)))
System.out.println("HCR_Scan");
else if (serviceClassID.equals(new UUID(0x1128)))
System.out.println("Common_ISDN_Access");
else if (serviceClassID.equals(new UUID(0x1129)))
System.out.println("VideoConferencingGW");
else if (serviceClassID.equals(new UUID(0x112A)))
System.out.println("UDI_MT");
else if (serviceClassID.equals(new UUID(0x112B)))
System.out.println("UDI_TA");
else if (serviceClassID.equals(new UUID(0x112C)))
System.out.println("Audio/Video");
else if (serviceClassID.equals(new UUID(0x112D)))
System.out.println("SIM_Access");
else if (serviceClassID.equals(new UUID(0x1200)))
System.out.println("PnPInformation");
else if (serviceClassID.equals(new UUID(0x1201)))
System.out.println("GenericNetworking");
else if (serviceClassID.equals(new UUID(0x1202)))
System.out.println("GenericFileTransfer");
else if (serviceClassID.equals(new UUID(0x1203)))
System.out.println("GenericAudio");
else if (serviceClassID.equals(new UUID(0x1204)))
System.out.println("GenericTelephony");
else if (serviceClassID.equals(new UUID(0x1205)))
System.out.println("UPNP_Service");
else if (serviceClassID.equals(new UUID(0x1206)))
System.out.println("UPNP_IP_Service");
else if (serviceClassID.equals(new UUID(0x1300)))
System.out.println("ESDP_UPNP_IP_PAN");
else if (serviceClassID.equals(new UUID(0x1301)))
System.out.println("ESDP_UPNP_IP_LAP");
else if (serviceClassID.equals(new UUID(0x1302)))
System.out.println("ESDP_UPNP_L2CAP");
else
System.out.println("unknown class of service");
}
break;
}

case 0x0002 : {System.out.println("ServiceRecordState:
" +
de.toString()); break; }
case 0x0003 : {System.out.println("ServiceID: " +
de.toString());
break; }
case 0x0004 :
{System.out.println("ProtocolDescriptorList: " +
de.toString()); break; }
case 0x0005 : {System.out.println("BrowseGroupList: "
+
de.toString()); break; }
case 0x0006 :
{System.out.println("LanguageBasedAttributeIDList: " +
de.toString()); break; }
case 0x0007 :
{System.out.println("ServiceInfoTimeToLive: " +
de.toString()); break; }
case 0x0008 :
{System.out.println("ServiceAvailability: " +
de.toString()); break; }
case 0x0009 :
{System.out.println("BluetoothProfileDescriptorList: "
+ de.toString()); break; }
case 0x000A : {System.out.println("DocumentationURL: "
+
de.toString()); break; }
case 0x000B :
{System.out.println("ClientExecutableURL: " +
de.toString()); break; }
case 0x000C : {System.out.println("IconURL: " +
de.toString()); break; }
case 0x0200 : {System.out.println("VersionNumberList:
" +
de.toString()); break; }
case 0x0201 :
{System.out.println("ServiceDatabaseState: " +
de.toString()); break; }
case 0x0000+0x0100 : {System.out.println("ServiceName:
" +
de.toString()); break; }
case 0x0001+0x0100 :
{System.out.println("ServiceDescription: " +
de.toString()); break; }
case 0x0002+0x0100 :
{System.out.println("ProviderName: " +
de.toString()); break; }
}
}
}
}

public void serviceSearchCompleted(int transID, int
respCode) {
if (respCode == SERVICE_SEARCH_COMPLETED)
System.out.println(" ... End of service discovery.");
if (respCode == SERVICE_SEARCH_DEVICE_NOT_REACHABLE)
System.out.println(" Remote device can't be
reached.");
if (respCode == SERVICE_SEARCH_ERROR)
System.out.println(" Error occured during service
discovery.");
if (respCode == SERVICE_SEARCH_NO_RECORDS)
System.out.println(" No service records found on the
device.");
if (respCode == SERVICE_SEARCH_TERMINATED)
System.out.println(" Service discovery canceled by the
application.");
}
}


__________________________________
Do you Yahoo!?
Yahoo! Mail SpamGuard - Read only the mail you want.
http://antispam.yahoo.com/tools


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
