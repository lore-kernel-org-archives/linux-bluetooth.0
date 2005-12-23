Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512230528y5b879d2bh2dbcb4e0fe18e974@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
In-Reply-To: <1135271815.6002.96.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
	 <1135196479.3781.10.camel@localhost>
	 <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
	 <1135271815.6002.96.camel@localhost>
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
Date: Fri, 23 Dec 2005 10:28:49 -0300

Hi Marcel,

do you mean have both implementations (SetProperty("mode") and SetMode) ?

BR,
Eduardo.



On 12/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > any suggestion about  Discoverable/Connectable parameter string? Maybe =
"Full" ?
>
> besides the property thing, I like to see something like:
>
>         SetMode(uint8 mode)     [Method]
>         uint8 GetMode()         [Method]
>         ModeChanged(uint8)      [Signal]
>
>         mode 0x00       =3D Off (means down or deep-sleep)
>         mode 0x01       =3D Connectable
>         mode 0x02       =3D Connectable and Discoverable
>
> What do you thing?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
Eduardo Rocha
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
