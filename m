Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b05010717425be7834d@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
In-Reply-To: <20050107120154.424e0927.henryk@ploetzli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <5256d0b05010520461ad68ff3@mail.gmail.com>
	 <1105014278.4299.19.camel@pegasus>
	 <5256d0b05010622152c32d3f4@mail.gmail.com>
	 <20050107120154.424e0927.henryk@ploetzli.ch>
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
Date: Sat, 8 Jan 2005 09:42:42 +0800

> > As seen below it detects the device, the voice settings and connects
> > with a RFCOMM channel but then it just sits there. I end up just
> > putting it into the background and try running the varoius examples.
> > Output of all included below. I get no sound at all. any ideas or
> > suggestions?
> 
> You did press the connect button on the headset, did you?

Yes. You put this headset into a Pairing mode, run btsco, it asks for
a pin for the headset and away you go.
 
> > [root@trinity btsco]# btsco 00:07:A4:0E:69:3D
> ...
> > [1]+ btsco 00:07:A4:0E:69:3D &
> > [root@trinity btsco]# mpg123 --au -
> > /home/audio/mp3/green_day/american_idiot/green_day-boulevard_of_broke
> > n_dreams.mp3
> > | sbc/sbcenc - | ./a2play 00:07:A4:0E:69:3D
> 
> That is not supposed to work. btsco (the program) and a2play are two
> different things. You should only be able to use one of them at any
> one time, if a2play works for you at all (which it doesn't, as the
> HS-810 can't do A2DP).

That may be my interpretation of the web page. Something for me to try
when I get some more time.

So does a2play etc ask for a pin to pair with the headset as well?

P


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
