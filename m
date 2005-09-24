Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43349C34.6030607@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
References: <432D6F49.80304@cyph.ath.cx>	 <20050919092548.1173.2@@vodafone.es>	 <1127217202.5168.36.camel@localhost.localdomain>	 <4333EA05.7090707@cyph.ath.cx>	 <1127483592.5623.5.camel@localhost.localdomain>	 <4333FE27.1050909@cyph.ath.cx> <1127485700.5623.8.camel@localhost.localdomain>
In-Reply-To: <1127485700.5623.8.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050203000307090101030009"
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
Date: Sat, 24 Sep 2005 08:22:12 +0800

This is a multi-part message in MIME format.
--------------050203000307090101030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>I don't support the 2.4 kernel anymore and I don't have the hardware to
>verify if this should work anyhow. I need the test hardware for it or
>you need to send a full decoded strace to see what they are doing.
>
>Regards
>
>Marcel
>  
>
I've just prepared the straces (filtered to only contain read/write to 
ttyS1).

dload.txt -- small executable which the native stack shells out to. Note 
the command line args contains the BD_ADDR.
ezx_bt.txt -- the stack itself . Multi-threaded user-space application 
with a reader and writer thread talking to ttyS1.

dload will be called first to initialize the chip (load firmware, set 
BD_ADDR), then ezx_bt will open ttyS1 and continue the initialization. 
This is a trace of the stack from the moment "Turn on Bluetooth" was 
pressed till "Bluetooth turned on" is displayed.

I have also hacked up a simple perl script to turn strace output into 
hcidump files. dload.dump and ezx_bt.dump are the files converted from 
the strace output.

--------------050203000307090101030009
Content-Type: text/plain;
 name="dload.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dload.txt"

425   execve("/usr/SYSbt/dload", ["/usr/SYSbt/dload", "/dev/ttyS1", "1", "460800", "00128a2d3d3e", "0"], [/* 46 vars */]) = 0
425   write(3, "\x01\x03\x0c\x00", 4)   = 4
425   read(3, "\x04\x0e\x04\x01\x03\x0c\x00", 8) = 7
425   write(3, "\x01\x18\xfc\x02\x55\xff", 6) = 6
425   read(3,  <unfinished ...>
425   <... read resumed> "\x04\x0e\x04\x01\x18\xfc\x00", 8) = 7
425   write(3, "\x01\x2e\xfc\x00", 4)   = 4
425   read(3,  <unfinished ...>
425   <... read resumed> "\x04\x0e\x04\x01\x2e\xfc\x00", 8) = 7
425   read(3, "41", 8)                  = 2
425   write(3, ":03000000028EB0BD", 17) = 17
425   read(3, ".", 8)                   = 1
425   write(3, ":0B1109008FE18DE2E4F5E375E30122C5", 33) = 33
425   read(3, ".", 8)                   = 1
425   write(3, ":101075008F15D3E515648094894008E5152437FF5D", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0C1085000290CEE5152430FF1290CE2220", 35) = 35
425   read(3, ".", 8)                   = 1
425   write(3, ":021058008F13F4", 15)   = 15
425   read(3, ".", 8)                   = 1
425   write(3, ":10105A00E5137804A2E713D8FB540FF514FF129096", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0B106A0075E513540FF514FF0290759C", 33) = 33
425   read(3, ".", 8)                   = 1
425   write(3, ":07117300907C187401F022CA", 25) = 25
425   read(3, ".", 8)                   = 1
425   write(3, ":100FC2001291328F1374D02513F513D3940940066E", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100FD20074F92513F51312913274D02FFFD39409AB", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0F0FE200400474F92FFFE513C454F04FF513FFCB", 41) = 41
425   read(3, ".", 8)                   = 1
425   write(3, ":010FF10022DD", 13)     = 13
425   read(3, ".", 8)                   = 1
425   write(3, ":100F8100128FC27519008F1A851A1BE51A751A007E", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F9100F519128FC2EF421AE4E51A251BF51B124F", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100FA1008FC27517008F18EF251BF51BE5187518F3", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100FB10000F517128FC2EF4218E4E518251BF51B47", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":010FC100220D", 13)     = 13
425   read(3, ".", 8)                   = 1
425   write(3, ":100EB000E4F5101291730510E510C394FA40F41292", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100EC0009091129132EF24A67003028F55241A706C", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100ED000F1E4F511F512F510128F81E510651A7025", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100EE00002E5196024128FC274902510F582E43453", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100EF0000EF583EFF074902510F582E4340EF5833F", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F0000E0251BF51B051080D2128FC2EF251BF5C3", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F10001B70AF7F401290CEE4F510AF107E00C37F", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F2000EF951AEE9519502574902510F582E4344A", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F30000EF583E0FDE5122518CBE5113517CB2F13", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F4000FFEE3B8F82F583EDF0051080CE7F01121E", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F50009058028EC21291737D0D7F381291097DD7", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F6000E30F1291097D400F1291097D510F1291EB", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":100F700009E51DB402077DC17F071290DE12903390", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":010F8000224E", 13)     = 13
425   read(3, ".", 8)                   = 1
425   write(3, ":0A111F00907F84EFF0A3F0A3F0220C", 31) = 31
425   read(3, ".", 8)                   = 1
425   write(3, ":10109100E4F51C1290211291737F0212911F12909C", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0B10A100ED50F3751D02128FF2D322F8", 33) = 33
425   read(3, ".", 8)                   = 1
425   write(3, ":0F10DE00907F80EFF0A3EDF0A37401F0E4F02217", 41) = 41
425   read(3, ".", 8)                   = 1
425   write(3, ":100FF200E4FD7F041290DE7D687F061290DE7DE1C3", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":101002000F1290DE7D607F0B1290DE7D707F0D12DD", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0810120090DE7D201F0290DE3C", 27) = 27
425   read(3, ".", 8)                   = 1
425   write(3, ":1010AC00907F80EFF0907F827402F0907F81E0FF60", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0110BC002211", 13)     = 13
425   read(3, ".", 8)                   = 1
425   write(3, ":0E10ED007F0A1290ACEF20E003D38001C322F3", 39) = 39
425   read(3, ".", 8)                   = 1
425   write(3, ":091129001290ED500312917322A3", 29) = 29
425   read(3, ".", 8)                   = 1
425   write(3, ":1010BD001291297F091290ACEF30E203D38001C366", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0110CD002200", 13)     = 13
425   read(3, ".", 8)                   = 1
425   write(3, ":0E10FB008F161290BD50FB907F87E516F022F5", 39) = 39
425   read(3, ".", 8)                   = 1
425   write(3, ":10103A00129129907FA0E0FFEF5408FF907FA0EF64", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0E104A00F0907FA0E0FFEF30E302C322D3223C", 39) = 39
425   read(3, ".", 8)                   = 1
425   write(3, ":0B11140012903A50FB907F87E0FF2212", 33) = 33
425   read(3, ".", 8)                   = 1
425   write(3, ":09113200E51DB402031291142220", 29) = 29
425   read(3, ".", 8)                   = 1
425   write(3, ":1010CE008F1E851E1EE51DB40205AF1E1290FB225B", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":10101A00F0A308B805FA22E4F8907F9C1412901AFB", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":10102A00E4907FA5F812901A227F007E6002045095", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":10114000758600900000ED2582F582EC3583F583ED", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":1011500005868E858F84758600E0A30586F0A3DB67", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":10116000F5758600D0F07454C0E074E3C0E0C0F0C0", 43) = 43
425   read(3, ".", 8)                   = 1
425   write(3, ":0311700002610712", 17) = 17
425   read(3, ".", 8)                   = 1
425   write(3, ":00000001FF", 11)       = 11
425   read(3, ".", 8)                   = 1
425   write(3, "@0010000000000000000000003C000000C400984513", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@000E00103520352055FF0000200004001EE3BF", 39) = 39
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010001E0A00500023FFC4FFC6FFC8FFCDFFD0FF6C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010002EDCFFEAFFC4FFEFFFF0FFF1FFF4FFF6FF86", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010003EFE0007FFEF000B000C000D000F0010007C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010004E16001D86A6C6E600000000000000000097", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010005E0000000000000000000000000000000092", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010006E09052B548B007A00007A051F9046D8E0C4", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010007E30E01A7F0190F1F91202807F085008904B", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010008EF3BE120280800690F37712028090006D0C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010009EE07014D24D7B017A00796DE47F407E06CC", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000AEFDFC124C2E8006FF126B8B50247F10E449", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000BEFEEF75F090901AFE1222A1E0B4040280B9", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000CE08B407028003B40B010EDFE590456DEE18", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000DEF0900055E06030E57A14702B7F04120624", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000EE29EF7023900056E07014D24D7B017A00F8", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001000FE7956E4FFFE7D03FC124C2E028112FF1294", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010010E6B8B500312812A907C187401F0D0F0741E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010011E8EC0E07454C0E0C0F0026107907C187489", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010012E01F07FC1128530900063EFF07FC312851E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010013E30900064EFF07FC8128530900065EFF0CC", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010014E7FD0128530900066EFF07FD2128530900E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010015E0067EFF07FD8128530900068EFF07FE6F1", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010016E128530900069EFF07FE712853090006ABB", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010017EEFF07FE912853090006BEFF07FEC128587", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010018E3090006CEFF0907DD97401F0A37409F0FB", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010019E7D867F4812854E7D887F5812854E7D085C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001001AE7F5212854E7DFF7F7912854E7D027F43F1", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@001001BE12854E7D8C7F5712854E7DD47F761285AB", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@001001CE4E7D200F12854E7D107F5012854E7F7C06", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@001001DE12854EE4900060F0A3F0900061E0645050", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001001EE6026900060E0FFC3944F501C907C187402", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001001FE01F0EF4480FD7F4112856A900061EFF0BF", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010020E900060E004F080D27DFE7F7612854E7DF8", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010021E600F12854E90005F741DF0FD7F7C12857D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010022E4E90005F7401F0E4900061F090005FE08A", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010023EC3940F5032900061E0FF64386029EF6480", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010024E3C602490005FE004F0907C187401F09004", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010025E005FE0FD7F4312854E12856D900061EFC9", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010026EF0E0242AF080C57F8C12858390005AEF2F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010027EF07F0C12858390005BEFF090005AE0FE49", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010028ED39F500302831390005D740CF090005CBA", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010029EEEF090005BE0FCA3E0D39C4024A3E0943E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002AE16501EE004F0E0FF6407600DEF640F606F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002BE0812857F90005CEFF0907C187401F0803E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002CED190005E740CF090005CECF090005AE05F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002DEFF90005CE0C39F400302844890005EE004", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002EE94005003028448E014F0E0FF6407600DB0", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001002FEEF640F600812858390005CEFF0907C181D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010030E7401F080C790005BE0FFEEC39F400302D4", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010031E839E90005E740CF090005CEFF090005A9B", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010032EE0FE90005CE0D39E402690005EE09416C6", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010033E501EE004F0E0FF6407600DEF640F6008EC", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010034E12858390005CEFF0907C187401F080CDE4", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010035E90005D740CF090005CEEF090005BE0FF9E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010036EA3E0C39F4003028448A3E094005003021D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010037E8448E014F0E0FF6407600DEF640F60083E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010038E12857F90005CEFF0907C187401F080CBAA", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010039E90005D7416F07F9612858390005CEFF0EE", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003AE7F1612858390005BEFF0A3E0FE6F601A5C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003BE90005BE0FFEED39F4007EE2404FEFF802B", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003CE04EF2404FF90005AEFF090005AE0FF90E3", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003DE005CE0C39F5024A3E09400401EE014F0A4", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003EEE0FF6407600DEF640F600812857F9000D8", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001003FE5CEFF0907C187401F080CF90005BE0A36E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010040EF090005E7416F090005AE0FF90005CE0F1", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010041EC39F502690005EE09400401EE014F0E072", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010042EFF6407600DEF640F600812858390005C17", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010043EEFF0907C187401F080CD90005EE025E026", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010044E2423F582E43400F583E0FEA3E0FF900060", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010045E5DE025E02423F582E43400F583E0FCA37F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010046EE0C39FFFEC9EFE900057F0A3EFF0C39405", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010047EF6EE6480947F5005754A028019D3900081", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010048E58E0940A900057E0648094804005E4F5AB", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010049E4A8003754A017451254AF582E43400F509", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004AE83E0F54B900062E004F0904950F0A3E534", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004BE4BF0FD7F5712854EE4907DD9F0A3F0905E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004CE0065E0FD7F4812854E900067E0FD7F528B", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004DE12854E90006BE0FD7F7912854E90006480", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004EEE0FD7F4312854E900066E0FD7F50128541", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001004FE4E90006CE0FD7F7C12854E900068E0FD12", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010050E7F5812854E900063E0FD7F4112854E901C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010051E0069E0FD7F7612854E90006AE0FD0F02C5", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010052E854E907DD2EFF0E4A3F0907DD8F004F0EC", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010053E907DD8E020E0F9128592907DD7E0FF22E1", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010054E907DD2EFF0E4A3F0A3EDF0E4907DD8F02F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010055E04F0907DD8E020E0F902859212854E904D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010056E7DD97448F07440F07448F07F8212853063", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010057E22EF4480FFAD077F5712856A8F4AE54A06", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010058E242AFF22754AC8D54AFD22090026F3A067", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010059E05A50005A5001AE490006DF0E490005644", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005AEF0D0F074A1C0E074F3C0E0C0F0E40261DA", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005BE0709002F826805CB0005CB0023120B51D3", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005CE53FFFD9043E6E0907C16F03029FD120BB0", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005DE5DD0F07473C0E07482C0E0C0F0026107B9", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005EE09001E979D05FA0005FA0012EF700CD057", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001005FEF074A2C0E07497C0E0C0F0026107090079", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010060E31BFD386180006180025205311907E2581", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010061EE0540F904F90F078A4E6904F91F0780F41", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010062ED0F074D5C0E074BFC0E0C0F0026107091D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010063E0064D3CF86490006490058904F90E0647D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010064E01704130663E758600904F91E0F5F0C323", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010065E94085030E5F02323904C3BC33582F5824D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010066E858284858385058405840586C3E004F030", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010067E7004A3E004F020670B0586E004F070041C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010068EA3E004F0D08274D2C0E074D3C0E0C08284", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010069E026107090033DC6346AD0006AD0027900A", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006AE4764E0FFC394014006EFD394054008125F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006BE04FD904764EFF0D0F07468C0E074DCC0C5", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006CEE0C0F002610709002A6DA806E00006E00E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006DE001E6004D3026107E55EB40104C302612B", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006EE07D0F074ACC0E0746DC0E0C0F0026107DA", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001006FE09001DC641870A00070A00117B04D0F0CD", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010070E7443C0E074C6C0E0C0F00261070900493E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010071EC8A58727000727003DE5666405600975B3", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010072E3801907F56E08939758601AC84AD8574A9", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010073E0CC32584F584E43585F585E0C333F0A339", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010074EE033F08C848D85D0F074B2C0E074C8C0F4", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010075EE0C0F002610709001B43AC077000077090", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010076E000FD0F074B9C0E07443C0E0C0F0026175", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010077E0709002D426A078B00078B002190468FD8", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010078EE0700B907C24E054FE4440F08002C2AD39", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010079ED0E0904352C082C083C0E00261070900DE", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007AE62834907B80007B800569041B91222ADCE", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007BE900008121D1470359041B91222AD9000B0", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007CE73121D14907D22F0A3E054FBF0C000754F", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007DE000600D500FCD000907D23E04404F0D04C", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007EEE090838CC082C083C0E0026107907D22BE", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001007FEE4F0D0E090834EC082C083C0E002610777", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@0010080E0900234ADF081A00081A0017903EDFE09D", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@0010081EF54B754A01D0F0904AE2C082C083C0F019", 43) = 43
425   read(3,  <unfinished ...>
425   <... read resumed> "@01", 8)      = 3
425   write(3, "@0010082E02610720000D00000000000000009098FB", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010083E0A00AD10987F047E11903D01E0B4FC6E6D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010084E903D00E0B40A67903D03E07025A3E0FA06", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010085EA3E0FBC0867586008A838B827586019025", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010086E3CC6758600E0758601F0D0867F057E0059", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010087E803CB40110A3E0FFA3E0FD120D25EF9024", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010088E3CC6F080E7B40213A3E0FFA3E0FDE4FB57", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0010089E120725EF903CC6EDF080D1A3E0FAA3E05D", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008AEFBA3E08A838B82F0903CC6F080BE903C26", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008BEC0740EF0A3EFF0A37401F0A30586903D73", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008CE00E0A30586F0A30586E00586F0A3EEF012", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008DEEF2402FF304F03026C92026B1E2A0004BB", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008EE012600210606000002020404060608087E", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@001008FE0A0A0000000000000202040406060808AE", 43) = 43
425   read(3, "@01", 8)                 = 3
425   write(3, "@0005090E0A0A7F00034E", 21) = 21
425   read(3, "@01", 8)                 = 3
425   write(3, "Z", 1)                  = 1
425   write(3, "\x01\x18\xfc\x02\x22\xfd", 6) = 6
425   read(3, "\x04\x0e\x04\x01\x18\xfc\x00", 8) = 7
425   write(3, "\x01\x01\xfc\x06\x3e\x3d\x2d\x8a\x12\x00", 10) = 10
425   read(3, "\x04\x0e\x04\x01\x01\xfc\x00", 8) = 7
425   write(3, "\x01\x20\xfc\x03\x00\x00\x00", 7) = 7
425   read(3, "\x04\x0e\x04\x01\x20\xfc\x00", 8) = 7
425   write(3, "\x01\x1c\xfc\x05\x00\x02\x00\x00\x00", 9) = 9
425   read(3, "\x04\x0e\x04\x01\x1c\xfc\x00", 8) = 7
425   write(3, "\x01\x1e\xfc\x05\x00\x00\x01\x03\x00", 9) = 9
425   read(3, "\x04\x0e\x04\x01\x1e\xfc\x00", 8) = 7
425   write(3, "\x01\x22\xfc\x01\x00", 5) = 5
425   read(3, "\x04\x0e\x04\x01\x22\xfc\x00", 8) = 7
425   write(3, "\x01\x27\xfc\x0a\x01\x03\x03\x00\x00\x00\x00\x00\x00\x00", 14) = 14
425   read(3, "\x04\x0e\x04\x01\x27\xfc\x00", 8) = 7
425   write(3, "\x01\x1a\x0c\x01\x03", 5) = 5
425   read(3, "\x04\x0e\x04\x01\x1a\x0c\x00", 8) = 7

--------------050203000307090101030009
Content-Type: text/plain;
 name="ezx_bt.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="ezx_bt.txt"

444   write(14, "\x01\x05\x10\x00", 4)  =3D 4
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x0b", 2)           =3D 2
443   read(14, "\x01\x05\x10\x00\x79\x01\x40\x0a\x00\x00\x00", 11) =3D 11=

444   write(14, "\x01\x33\x0c\x07\x1c\x03\x00\x01\x00\x00\x00", 11) =3D 1=
1
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x33\x0c\x00", 4)   =3D 4
444   write(14, "\x01\x09\x0c\x00", 4)  =3D 4
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x05", 2)           =3D 2
443   read(14, "\x01\x09\x0c\x00\x00", 5) =3D 5
444   write(14, "\x01\x20\x0c\x01\x00", 5) =3D 5
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x20\x0c\x00", 4)   =3D 4
444   write(14, "\x01\x22\x0c\x01\x00", 5) =3D 5
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x22\x0c\x00", 4)   =3D 4
444   write(14, "\x01\x26\x0c\x02\x60\x00", 6) =3D 6
443   read(14, "\x04", 1)               =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x26\x0c\x00", 4)   =3D 4
443   read(14,  <unfinished ...>
444   write(14, "\x01\x13\x0c\xf8\x43\x79\x70\x68\x27\x73\x20\x45\x36\x38=
\x30\x49\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\=
x00", 252) =3D 252
443   <... read resumed> "\x04", 1)     =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x13\x0c\x00", 4)   =3D 4
443   read(14,  <unfinished ...>
444   write(14, "\x01\x1a\x0c\x01\x02", 5) =3D 5
443   <... read resumed> "\x04", 1)     =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x1a\x0c\x00", 4)   =3D 4
443   read(14,  <unfinished ...>
444   write(14, "\x01\x24\x0c\x03\x04\x22\x58", 7) =3D 7
443   <... read resumed> "\x04", 1)     =3D 1
443   read(14, "\x0e\x04", 2)           =3D 2
443   read(14, "\x01\x24\x0c\x00", 4)   =3D 4
443   read(14,  <unfinished ...>

--------------050203000307090101030009
Content-Type: application/octet-stream;
 name="dload.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dload.dump"

BAAAAAAAAAAAAAAAAQMMAAcAAQAAAAAAAAAAAAQOBAEDDAAGAAAAAAAAAAAAAAABGPwCVf8H
AAEAAAAAAAAAAAAEDgQBGPwABAAAAAAAAAAAAAAAAS78AAcAAQAAAAAAAAAAAAQOBAEu/AAG
AAAAAAAAAAAAAAABGPwCIv0HAAEAAAAAAAAAAAAEDgQBGPwACgAAAAAAAAAAAAAAAQH8Bj49
LYoSAAcAAQAAAAAAAAAAAAQOBAEB/AAHAAAAAAAAAAAAAAABIPwDAAAABwABAAAAAAAAAAAA
BA4EASD8AAkAAAAAAAAAAAAAAAEc/AUAAgAAAAcAAQAAAAAAAAAAAAQOBAEc/AAJAAAAAAAA
AAAAAAABHvwFAAABAwAHAAEAAAAAAAAAAAAEDgQBHvwABQAAAAAAAAAAAAAAASL8AQAHAAEA
AAAAAAAAAAAEDgQBIvwADgAAAAAAAAAAAAAAASf8CgEDAwAAAAAAAAAHAAEAAAAAAAAAAAAE
DgQBJ/wABQAAAAAAAAAAAAAAARoMAQM=
--------------050203000307090101030009
Content-Type: application/octet-stream;
 name="ezx_bt.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ezx_bt.dump"

BAAAAAAAAAAAAAAAAQUQAA4AAQAAAAAAAAAAAAQOCwEFEAB5AUAKAAAACwAAAAAAAAAAAAAA
ATMMBxwDAAEAAAAHAAEAAAAAAAAAAAAEDgQBMwwABAAAAAAAAAAAAAAAAQkMAAgAAQAAAAAA
AAAAAAQOBQEJDAAABQAAAAAAAAAAAAAAASAMAQAHAAEAAAAAAAAAAAAEDgQBIAwABQAAAAAA
AAAAAAAAASIMAQAHAAEAAAAAAAAAAAAEDgQBIgwABgAAAAAAAAAAAAAAASYMAmAABwABAAAA
AAAAAAAABA4EASYMAPwAAAAAAAAAAAAAAAETDPhDeXBoJ3MgRTY4MEkAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAcAAQAAAAAAAAAAAAQOBAETDAAFAAAAAAAAAAAAAAABGgwBAgcAAQAAAAAAAAAA
AAQOBAEaDAAHAAAAAAAAAAAAAAABJAwDBCJY
--------------050203000307090101030009--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
