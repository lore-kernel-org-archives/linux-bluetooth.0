Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0512141035w5cc40fach9d77ead5df00cf2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Remote name delay
In-Reply-To: <1134511532.24447.18.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb0512011117i730f7dd0p4ffc099d06a09cb8@mail.gmail.com>
	 <1133470780.18554.2.camel@blade>
	 <e1effdeb0512020321g2b492f1cl5c553d7c3b24bfb8@mail.gmail.com>
	 <1133523028.20834.8.camel@blade>
	 <e1effdeb0512020833q3f319166lfe8e63e612a86c4e@mail.gmail.com>
	 <1133548573.20834.83.camel@blade>
	 <e1effdeb0512131359x7ff7a330j435a8bde0779e958@mail.gmail.com>
	 <1134511532.24447.18.camel@blade>
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
Date: Wed, 14 Dec 2005 16:35:44 -0200

Hi Marcel,

ok. We will extend the GetProperty(string:info) returning the
following arguments:
- MAC Address: String
- Device Status: String(UP/DOWN)
- Manufacturer: String
- HCI Version: String
- HCI Revision: String
- LMP Version: String
- LMP Sub Version: String

The firmware revision was removed from the dialog because it's not
possible get this info.


Regards,
Claudio

On 12/13/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > There are some device properties I would like show in the adapter
> > configuration dialog.
> > http://www.cin.ufpe.br/~ckt/gbluezconf/config.gif
> >
> > Do you agree provide D-Bus services to retrieve Manufacturer and
> > firmware details? We can extend the GetProperty to support get these
> > infos.
>
> feel free to do it. That's fine with me.
>
> > Currently I am solving some D-Bus signals filters and multiple dialogs
> > issues. When it become stable I will send the first prototype. I have
> > to send until next monday because I have vacations :)
>
> Can't wait to give it a shoot. Will create a bluez-gnome CVS repository
> then.
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
---------------------------------------------------------
Claudio Takahasi
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
