Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: John McDougald <jmcdougald@kirkiss.ky>
To: Linux@feline-soul.com, BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200608232300.58022.Linux@feline-soul.com>
References: <1597.216.47.59.131.1156371924.squirrel@webmail.feline-soul.net>
	<200608232205.01719.Linux@feline-soul.com>
	<44ED2C3B.9020400@xmission.com>
	<200608232300.58022.Linux@feline-soul.com>
Date: Thu, 24 Aug 2006 08:18:53 -0400
Message-Id: <1156421933.7759.7.camel@trevor.KIRK.KY>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Logitech Traveler Headset. pin never seen and
	i	am	never asked.
Reply-To: jmcdougald@kirkiss.ky,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have the same problem.  It appears that the latest version of hcid no
longer recognizes the pin_helper definition inside the hcid.conf file.
As I am also running Debian (unstable) I hoped that the bluez-pin
package would be "linked" to the hcitool cc xx:xx:xx:xx:xx:xx
application and would pop up a window allowing me to enter a password
during the pairing phase.  However, there is a dependancy problem and
the bluez-pin package cannot be installed.  I crammed it in (using dpkg
-i --force-all) and the bluez-pin package installed and the hcid
application showed that a pin application was registered, but, when I
tried to pair I was never presented with a dialog box requesting a pin
and the pairing failed.

I should mention that this logitech headset (HS04 V01) pairs with this
notebook when I boot into windowsXP so there is no hardware problem.

I am hoping that I am just an "apt-get update; apt-get dist-upgrade"
away from a working bluetooth headset }:-) as the "break" with the
pin_helper option in hcid.conf must have broken a lot of working
bluetooth configurations.

John

On Wed, 2006-08-23 at 23:00 -0600, Bearcat M. Sandor wrote:
> Brad,
> I've done so. That was the page i was following.
> The page specifies the following fixes:
>   If you can't pair or connect with the headset, did you pair it with another 
> device?  *There is no other device*
> Did it help to reset the pairing by removing /etc/bluetooth/link_key 
> or /var/lib/bluetooth/[dongleaddr]/linkkeys or by putting the headset in pair 
> mode?  *These files have never existed and it has never been paired. How do i 
> put it in paired mode?*
> 
> You may have to redo this often if you try to dual-boot windows or if you use 
> the same dongle on another computer. *Never been done*
> Be sure to set "auth disable" and "encrypt disable" 
> in /etc/bluetooth/hcid.conf. *Done*
> 
> This is a headset that i ordered from Ebay. A white box.  Do i *know* that the 
> pin is still the default? No. However i should still be asked for the pin at 
> some point.
> 
> Again, when i issue a btsco 00:0D:44:4F:37:72 i get:
> Error: Failed to connect to SDP server: Permission denied
> Assuming channel 2
> 
> Can't connect RFCOMM channel: Permission denied
> 
> 
> Thank you for the help. Any other suggestions? I have to get this working.
> 
> Bearcat
>   
> On Wednesday 23 August 2006 22:34 in an email titled "Re: [Bluez-users] 
> Logitech Traveler Headset. pin never seen and i am	never asked." Brad Midgley 
> wrote:
> >Bearcat
> >
> >> It seems like this is the same old problem that has been plaguing me for a
> >> month now. I need to feed this headset a pin of 0000 and i am NEVER asked
> >> for a pin no matter what i put into the config file.
> >
> >we've had this problem from time to time... the only thing that
> >sometimes works is to reset the pairing. some suggestions are listed at
> >the end of bluetooth-alsa.sf.net.
> >
> >brad
> >
> >
> >
> >
> >-------------------------------------------------------------------------
> >Using Tomcat but need to do more? Need to support web services, security?
> >Get stuff done quickly with pre-integrated technology to make your job
> > easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> > Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> > _______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
