Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Clinical Science Systems <info@clinicalsciencesystems.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Strange receive buffer mix-up when accessing /dev/rfcomm0 as a file
References: <200412291538.46078.pckoster@wanadoo.nl> <1104335737.6389.3.camel@notepaq>
In-Reply-To: <1104335737.6389.3.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200412292225.44222.info@clinicalsciencesystems.com>
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
Date: Wed, 29 Dec 2004 22:25:44 +0100

Hi Marcel,

thank you very much for your quick and great advice. I'm not quite proficient 
yet with the stty syntax on linux, but an initial 'stty -F /dev/rfcomm0 nl' 
solved the 0D -> 0A issue. I'll sort it out next year I guess.....

My application has to be used on multiple platforms, hence my approach for 
serial file based access.

Thanks again and best wishes for 2005!

Regards,

Paul

Op woensdag 29 december 2004 16:55, schreef Marcel Holtmann:
> Hi Paul,
>
> > I've got a strange problem when reading the /dev/rfcomm0 device as a
> > file. It boils down to a mix-up of one byte from the inputbuffer.
> >
> > My system information is as follows:
> >
> > - My transceiving USB key is a MSI PC2PC Bluetooth
> > - Mobile device is a TMSI Mobi8e bluetooth ExG amplifier with serial
> > service (SP) enabled and bound via "rfcomm bind 0 00:A0:96:1D:77:A8 1"
> >
> > Some useful system command outputs:
> >
> > [root@paul ~]# rpm -qa | grep bluez
> > bluez-hcidump-1.11-1
> > bluez-utils-2.10-2
> > bluez-pin-0.23-3
> > bluez-libs-2.10-2
> > bluez-bluefw-1.0-6
> >
> > [root@paul ~]# uname -r
> > 2.6.9-1.678_FC3
> >
> > [root@paul ~]# rfcomm
> > rfcomm0: 00:A0:96:1D:77:A8 channel 1 closed
> >
> > I access the created /dev/rfcomm0 node as a standard file. Therefore I've
> > written a small test program which is listed below. To get the device
> > going a specific protocol is needed, but is basically boils down to
> > sending 3 packets and waiting for acknowledge packets which are all sent
> > and received well and then a series of packets from the mobi device,
> > containing the measured data. These last type of packets is sent
> > continiously from the device. I fetch them continuously using fgetc.
> >
> > Every packet starts with 0xAAAA (so called blocksync).
> >
> > The problem lies in these last type of packets. I do receive them, but
> > there is a discrepancy between what "hcidump -x" says, and what I
> > actually receive from the buffer. I should receive i.e.:
> >
> > AA AA 0D 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00
> > 80 00 00 80 00 0C 49 46
> >
> > but I get:
> >
> > AA AA >0A< 01 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00 80 00 00
> > 80 00 00 80 00 0C 49 46
> >
> > The 0D (13) has become a 0A (10), but the rest of the packet is totally
> > perfect. This is the case with ALL packets received of this kind. It
> > should be 0D according to the protocol (and hcidump).
> > I've listed the relevant pieces of hcidump output as well as program
> > output below (program output is in decimal notation however. 0xAA = 170,
> > so the relevant sequence is 170 170 10 01 at the end of the output)
> >
> > Does anyone have a clue on what this could be? Thanks in advance for your
> > help.
>
> sounds like an ASCII end of line/carrige return clash. Try to use the
> RFCOMM socket interface directly or set your TTY to raw mode.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
________________________________________________________________________

Clinical Science Systems
Ter Weerlaan 58
2241 VC Wassenaar

Tel.   : +31 (0)70 514 21 06
GSM    : +31 (0)6 110 44 725

URL    : http://www.clinicalsciencesystems.com
E-mail : info@clinicalsciencesystems.com


 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
