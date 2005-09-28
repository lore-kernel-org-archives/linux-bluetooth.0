Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth filesystem integration
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127906387.14254.27.camel@bluez.bueche.ch>
References: <1127865130.15926.18.camel@panic>
	 <1127899309.14281.7.camel@bluez.bueche.ch>
	 <1127899931.5321.16.camel@localhost.localdomain>
	 <1127906387.14254.27.camel@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1127918552.32222.83.camel@bnocera.surrey.redhat.com>
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
Date: Wed, 28 Sep 2005 15:42:32 +0100

On Wed, 2005-09-28 at 13:19 +0200, Charles Bueche wrote:
> On mer, 2005-09-28 at 11:32 +0200, Marcel Holtmann wrote:
> > Hi Charles,
> > 
> > > > So this post is basically to anounce btfs and to gether some ideas on
> > > > what you guys think is need and useful.
> > > 
> > > That will be great, eg to automatically rsync new pictures taken from my
> > > phone to a local dir. I know there is a kbluetoothd plugin, but
> > > rsync/btfs seems much more "UNIX-like" to me.
> > > 
> > > What would be great is to see phone contacts as virtual VCard files (one
> > > file per contact). Not sure if it is possible, but you asked for
> > > ideas :-)
> > > 
> > > Seeing my Palm T5 agenda as iCal file would be the top... OK, I stop
> > > dreaming :-/
> > 
> > do you have any thoughts how the directory structure of this filesystem
> > should look like. Let's discuss how we design it.
> 
> not sure if my ideas make sense, as I don't know the internal of
> bluez/btfs/devices. My view is from a user's point.
> 
> - first level : device name
> 
> - second level : the device's applications. Examples :
<snip>

Think of ObexFTP as FTP over Bluetooth. There's no per-application
ObexFTP service...

---
Bastien Nocera <hadess@hadess.net> 
"Manchester United in Brazil? I hope they all get bloody diarrhoea" -
Brian Clough, on Manchester United's decision to opt out of the FA Cup
to play in the World Club Championship in 2000.



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
