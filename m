Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <13106791.1127644720609.JavaMail.Administrator@appsrv>
From: Ivy <ivy@cashette.com>
To: bluez-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Voice setting for U-law and A-law.
Cc: Andreas Beck <becka-bzdvl@bedatec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sun, 25 Sep 2005 03:38:40 -0700 (PDT)


Hi Marcel , Andy ..


           Thanks for bare with me so far ...

            Based on your input and  Mailing list info, I have choosen alternate setting 1 in interface 1. I am using CSR chipset Bluetooth Dongle. My voice setting value is 0x140. (mu-law). If i am submitting URBS to read, my system is hanging.. I am using 2.6.12 kernel. if i am setting default voice setting value 0x60... It is not hanging ... I dont know what would be the probelm... Any one tips  to track down this problem ...  

Thanks
-Ivy

--- Ivy <ivy@cashette.com> wrote:
> 
> 
> 
> --- Andreas Beck <becka-bzdvl@bedatec.de> wrote:
> > Ivy <ivy@cashette.com> wrote:
> > > > >  xxxxxxxxxx1xxxxx Input Sample Size: 16 bit   (Can i use 8 bit ?) 
> > > > IMHO you should, if you want alaw/ulaw.
> > > You meant to use 16 Bit or 8 bit ?..
> > 
> > 8 bit.
> > 
> > > > > xxxxxxxxxxx010xx # of bits padding at MSB: 2 (if i use 16 Bit, 
> > > > > 2bit's of MSB is needed for padding, coz only 14bits are enough 
> > > > > for u-law) 
> > > > AFAIK 8 bits are enough - could you explain?
> > > U-LAW takes 14bits of linear PCM data as input and generates 8 bit 
> > > compressed data. Am i correct ?
> > 
> > Yes. That is correct.
> > 
> > > Thatswhy i assume that it needs 16 bits for INPUT Sample size and 
> > > 2 bit offset in MSB position. 
> > 
> > No - I suppose this is a misunderstanding about "input".
> > 
> > The SCM link via bluetooth uses its own encoding anyway (see the 
> > comment about on air coding at the end of the list).
> > 
>  
>       SCO LInk via bluetooh uses CVSD encoding...  
>    
> > INPUT means what you feed in/get out at the driver side.
> > 
> > That is, if you choose alaw, you already feed alaw data.
> > 
> > Otherwise you could just use linear anyway. There would be no use in
> > converting to alaw first and then again to the air coding format.
> > 
> > Basically you will want to use alaw/ulaw, if you want to feed the
> > received data directly into a device that wants this data format anyway,
> > saving unnecessary conversions.
> > 
> 
>    xxxxxx01xxxxxxxx Input Coding: u-law
>    xxxxxxxx01xxxxxx Input Data Format: 2"s complement 
>    xxxxxxxxxx0xxxxx Input Sample Size: 8 bit
>    xxxxxxxxxxx000xx # of bits padding at MSB: 0
>    xxxxxxxxxxxxxx00 Air Coding Format: CVSD
> 
>                0101000000 = 0x140 is the correct value ?. isnt it ?
> hciconfig hci0 voice 0x140. Is it necessary to change my USB alternate setting for  the above changes ?. Right now it is placed in alternate setting 2. (Endpoint value 17). Thanks for bare with me 
> 
> Thanks
> -IVY  
> 
> 
> 
> > 
> > CU, ANdy
> > 
> > 
> > -------------------------------------------------------
> > SF.Net email is sponsored by:
> > Tame your development challenges with Apache's Geronimo App Server. 
> > Download it for free - -and be entered to win a 42" plasma tv or your very
> > own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> __________________________
> Free 3000MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> __________________________
> Free 3000MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com

__________________________
Free 3000MB email. Stops spam 100%. No banner ads. No popup ads. http://www.cashette.com


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
