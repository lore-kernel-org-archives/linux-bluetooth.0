Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
In-Reply-To: <1135196479.3781.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
	 <1135196479.3781.10.camel@localhost>
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
Date: Thu, 22 Dec 2005 10:11:08 -0300

Hi Marcel,

any suggestion about  Discoverable/Connectable parameter string? Maybe "Ful=
l" ?

BR,
Eduardo.


On 12/21/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Eduardo,
>
> > I agree about the "mode" property. But about Up and Down we have to
> > consider issues like security and power save. Will the Off mode
> > (nopiscan) be equivalent to device Down in power consumption?
>
> this is implementation specific. On some embedded devices, this might be
> the same as deep-sleep. Others might disconnect the device from the bus
> or simply call down. The user interface shouldn't have to care about it.
>
> I think that we also need something like a status which shows if the
> device is idle, running an inquiry or have active connections.
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
