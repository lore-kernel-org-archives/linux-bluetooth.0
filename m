Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41DE6E20.8080503@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
References: <5256d0b05010520461ad68ff3@mail.gmail.com>	<1105014278.4299.19.camel@pegasus>	<5256d0b05010622152c32d3f4@mail.gmail.com> <20050107120154.424e0927.henryk@ploetzli.ch>
In-Reply-To: <20050107120154.424e0927.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 07 Jan 2005 12:10:24 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Maybe we have to improve the documentation what btsco.ko, btsco, btsco2
and a2play are and what they do - and what they do not :)

to bad I have so much work to do :(

regards,
~  Lars

Henryk Pl=F6tz wrote:
| Moin,
|
| Am Fri, 7 Jan 2005 14:15:44 +0800 schrieb Peter Robinson:
|
|
|>As seen below it detects the device, the voice settings and connects
|>with a RFCOMM channel but then it just sits there. I end up just
|>putting it into the background and try running the varoius examples.
|>Output of all included below. I get no sound at all. any ideas or
|>suggestions?
|
|
| You did press the connect button on the headset, did you?
|
|
|>[root@trinity btsco]# btsco 00:07:A4:0E:69:3D
|
| ...
|
|>[1]+ btsco 00:07:A4:0E:69:3D &
|>[root@trinity btsco]# mpg123 --au -
|>/home/audio/mp3/green_day/american_idiot/green_day-boulevard_of_broke
|>n_dreams.mp3
|>| sbc/sbcenc - | ./a2play 00:07:A4:0E:69:3D
|
|
| That is not supposed to work. btsco (the program) and a2play are two
| different things. You should only be able to use one of them at any
| one time, if a2play works for you at all (which it doesn't, as the
| HS-810 can't do A2DP).
|


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3m4gQWC6DTWkDAoRAt0+AJwI2FmEti8TF7BPlix5Iy3MBHcFSwCfeh+M
+0BM6oKH8T/vu+WmM+KCu20=3D
=3DbvFY
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
