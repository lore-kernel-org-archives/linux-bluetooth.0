Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec05052412274f04a335@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How to turn off Discoverable?
In-Reply-To: <AC1F8662-8C37-4138-8C33-5E0AAEFE96CA@pepper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <AC1F8662-8C37-4138-8C33-5E0AAEFE96CA@pepper.com>
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
Date: Tue, 24 May 2005 15:27:58 -0400

run as root:

hciconfig hci0 pscan

to set it permanently, edit /etc/bluetooth/hcid.conf (or wherever your
hcid.conf is) and disable inquiry scan.

This makes it undiscoverable, but still allows pages (other devices to
connect, if they know your machine's bt address)

-albert

On 5/24/05, Michael Frey <mfrey@pepper.com> wrote:
> Is there an hciconfig command to make my bluetooth module not
> "Discoverable"?
>=20
> Thanks,
> Michael
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
