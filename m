Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Anthony R. J. Ball" <ant@suave.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Socket Rev H?
Message-ID: <20051009021816.GA25928@suave.net>
References: <20051007150204.GA18594@suave.net> <1128774980.5212.6.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1128774980.5212.6.camel@blade>
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
Date: Sat, 8 Oct 2005 22:18:16 -0400


  Ugh.. still having problems... looking all over for serial_cs modules
for 2.4.18-rmk7-pxa3-embedix... I found some precompiled ones that I
loaded but dmesg says "ds: unable to create instance of 'serial_cs'!"

  Also, when dmesg says
ttyS03 at port 0xc48603f8 (irq = 35) is a 16C950/954
 
  I assume that means /dev/ttyS3... I tried
hciattach ttyS3 csr
hciattach ttyS3 bcsp
and
hciattach ttyS3 any

  None of those seem to work.. any gives back hciconfig, but the
address is all zeros... 

  Thanks a lot for the help, sorry I haven't figured this out already...



On Sat, Oct 08, 2005 at 02:36:20PM +0200, Marcel Holtmann wrote:
> Hi Anthony,
> 
> >   I have been looking all around and going crazy. It seems like 
> > every time I buy Linux supported hardware the manufacturer has
> > upped the revision to screw my compatibilty (WRT54GS, PVR-150, now
> > the socket card, sigh).
> > 
> >   As far as I can tell this card does work, but I am having trouble
> > finding directions on which incantation I need to perform the proper
> > magic.
> > 
> >   I am trying to put it on a Zaurus SL-5500 running OpenZaurus 3.5.3
> > which has a 2.4x kernel in it.
> > 
> >   Can someone point me in the right direction, please? 
> 
> the revision H of the card should work with the serial_cs driver and
> then you have to use the hci_uart driver and hciattach to make this card
> known to the Bluetooth core.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

-- 
     www.suave.net - Anthony Ball - ant@suave.net
        OSB - http://rivendell.suave.net/Beer
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Good printers do it without wrinkling the sheets. 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
