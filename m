Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <461C8164.8010705@gmail.com>
Date: Wed, 11 Apr 2007 10:34:12 +0400
From: Sergey Smirnov <svs1957@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <003e01c77bf3$6270d6a0$9d0cc70a@dlh.st.com>
In-Reply-To: <003e01c77bf3$6270d6a0$9d0cc70a@dlh.st.com>
Subject: Re: [Bluez-devel] btsco: Operation not supported
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Sorry for stupid question.
Part of what you want to see?
Problem in function sco_connect of btsco.c:
 static int sco_connect(bdaddr_t * src, bdaddr_t * dst, uint16_t * handle,
                       uint16_t * mtu)
{
        struct sockaddr_sco addr;
        struct sco_conninfo conn;
        struct sco_options opts;
        int s;
        unsigned int size;

        if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
                return -1;
        }

        memset(&addr, 0, sizeof(addr));
        addr.sco_family = AF_BLUETOOTH;
        bacpy(&addr.sco_bdaddr, src);
        if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
                close(s);
                return -1;
        }

        memset(&addr, 0, sizeof(addr));
        addr.sco_family = AF_BLUETOOTH;
        bacpy(&addr.sco_bdaddr, dst);
        if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
                close(s);
                return -1;
        }
...
Here hciconfig -a
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:7C:36 ACL MTU: 340:4 SCO MTU: 0:0
        UP RUNNING PSCAN ISCAN
        RX bytes:204 acl:0 sco:0 events:15 errors:0
        TX bytes:382 acl:0 sco:0 commands:15 errors:0
        Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'svs-zaurus-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x21a
        Manufacturer: Nokia Mobile Phones (1)
It's strange for me that SCO MTU is 0:0
I've tried to change it but its didn't help.

Tell me please what information do you need.
Thanks.

Mayank BATRA wrote:
>> Here is some part of hcidump while sco connect:
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>     handle 1 packets 1
>>> HCI Event: Command Status (0x0f) plen 4
>>     Add SCO Connection (0x01|0x0007) status 0x11 ncmd 4
>>     Error: Unsupported Feature or Parameter Value
> 
> Can you provide the part showing the Add SCO connection command?
> You might have to try different packet types.
> 
> Best Regards,
> 
> Mayank
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
