Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170606061337m3ef2e630k702a7e3ef3509256@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:37:06 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149616008.9380.11.camel@neutrino.cosmos.net>
MIME-Version: 1.0
References: <1149543750.14142.11.camel@neutrino.cosmos.net>
	<1149544649.7238.1.camel@localhost>
	<1149616008.9380.11.camel@neutrino.cosmos.net>
Subject: Re: [Bluez-users] crazy mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
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

On 6/6/06, Didier LINK <didier.link@wanadoo.fr> wrote:

> Any idea ??

Hi,

you could execute:

  # hcidump -t -X -V -B -w log

then move your mouse a little bit and then hit ctrl-c and do:

  # gzip -9 log

And then send us log.gz or send us a link to somewhere we can download
it. That way we might have an idea of what is going on. :-)

Best regards,

-- Ulisses


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
