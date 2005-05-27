Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050527084147.27219.qmail@web50707.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
Subject: Re: [Bluez-users] Problem with dund and LG 325 phone.
To: bluez-users@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Fri, 27 May 2005 01:41:47 -0700 (PDT)

I have the same phone.

Can you tell me what steps you had to do to actually
get the phone paired with your computer?

thx

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eric,
> 
> > thanks that helped and at one point I got the
> phone dialing, but not 
> > anymore. I'm still getting "Connection refused"
> errors. The computer and phone 
> > are definitely paired since I can use
> kbthandsfree.
> > 
> > If I issue these commands:
> > 
> >    748  echo 1 > /proc/sys/net/ipv4/ip_forward
> >    749  rfcomm bind 0 08:00:37:13:A1:C7 4
> >    750  pppd /dev/rfcomm0 debug nocrtscts novj
> novjccomp defaultroute connect 
> > 'chat -v -f /root/sprint-chat'
> > 
> > May 26 20:38:12 localhost pppd[4987]: pppd 2.4.3
> started by root, uid 0
> > May 26 20:38:13 localhost hcid[3622]:
> link_key_request (sba=00:10:60:AA:5C:CE, 
> > dba=08:00:37:13:A1:C7)
> > May 26 20:38:13 localhost pppd[4987]: Failed to
> open /dev/rfcomm0: Connection 
> > refused
> > May 26 20:38:13 localhost pppd[4987]: Exit.
> > 
> > This is what hcidump shows (sorry for the length,
> but I don't know what's 
> > important)
> 
> try to reset/reboot your phone and check the RFCOMM
> channel number again
> with sdptool. It looks like that this channel is no
> longer accepting new
> connections.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create
> apps using Yahoo!
> Search APIs Find out how you can build Yahoo!
> directly into your own
> Applications - visit
>
http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new Resources site
http://smallbusiness.yahoo.com/resources/


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
