Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Infineon hardware "SingleStone PBA31307"
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4acb84a5e2.4a5e24acb8@fh-wolfenbuettel.de>
References: <4acb84a5e2.4a5e24acb8@fh-wolfenbuettel.de>
Content-Type: text/plain
Message-Id: <1139847877.4378.8.camel@localhost>
Mime-Version: 1.0
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
Date: Mon, 13 Feb 2006 17:24:37 +0100

Hi Goetz,

> I am trying to get the Infineon bluetooth hardware to work. Exact name
> is: PBA31307 SingleStone. It is a bluetooth module with a serial interface. 
> See link:
> http://www.infineon.com/cgi-bin/ifx/portal/ep/channelView.do?channelId=-65244&channelPage=%2Fep%2Fchannel%2FproductOverview.jsp&pageTypeId=17099
> 
> I am using the 2.4.19 kernel with bluez-libs-2.25 and bluez-utils-2.25. 
> 
> Maybe someone can aggree or correct me on the assumption that  
> 
> 1. I need to add the initialisation sequence for this hardware to
> bluez-utils-2.25/tools/hciattach.c ?
> 
> 2. and then use i.e. "hciattach -s 115200 /dev/ttyS2 infineon" in the
> shell followed by "hciconfig hci0 up" etc ?

that is basically what is needed to make this device work.

> The problems will arise with the correct initialisation I guess. I do
> have a datasheet with a suggested sequence which is:
> 
> --------------------------------------------------------
> 
> # Initialisation sequence on PMB8761 v7.50 for Singlestone
> # Switch to manufacturer mode
> 
> send: Infineon_Manufacturer_Mode
> Mode_Switch: 0x01
> Reset: 0x00
> 
> received: Command_Complete
> Num_HCI_Command_Packets: 0x01
> Command_Opcode: Infineon_Manufacturer_Mode (0xfc11)
> Status: Command succeeded (0x00)
> 
> send: Infineon_Write_Clock_Data
> Clock_Control1: 0x000088
> Clock_Control2: 0x641415
> Freq_Dev: 0xc8
> RF_Boost: 0x3c
> Startup_Control: 0x02
> Sascal: 0x00
> # UART rate is 115200 bit/s
> Sabaud: 0x70
> Multiple_Clock: 0x000000b4b405
> LPM_Drift: 0x00
> 
> received: Command_Status
> Status: Command succeeded (0x00)
> Num_HCI_Command_Packets: 0x01
> Command_Opcode: 0xfc1e
> 
> --------------------------------------------------------
> 
> and so on. Question: what about the longer hex numbers, i.e.
> Command_Opcode: Infineon_Manufacturer_Mode (0xfc11) ? I figured out the
> 2 digit hex numbers, but how to send the longer ones as hci command? 

Looks like the chip is talking HCI even when it is not initialized. The
correct byte streams depends on the on the structure of these vendor
specific commands. Send me the datasheet and we see how it should look
like.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
