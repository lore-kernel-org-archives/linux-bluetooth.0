Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
In-Reply-To: <1132942092.5577.21.camel@blade>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <20051118112611.GA17062@localhost.localdomain>
	 <3013cac80511180500h5539d5d9y3f19ce224f9e38b7@mail.gmail.com>
	 <1132660308.28644.37.camel@blade>
	 <3013cac80511221152t2911f513jb28f3944097c1b09@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
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
Date: Fri, 25 Nov 2005 15:34:51 -0300

Hi Marcel,

On 11/25/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> For what do we need a special bluezadmin group? I think that the user
> should enter the root password for configuration or it should be console
> or session user.

a group is needed for better dbus client security. If only root is
allowed, the client will have to be run as root (by sudo or suid). In
this case the machine security can be compromised by a buffer overflow
in the client. If we use a group, users that can change bluetooth
props should be added to that group, and the client application can be
run as a normal user. So if the dbus client app has a flaw, it will
not compromise the whole machine.
Of course the dbus server need to be executed as root.

BR,
Eduardo.


> Hi Claudio,
>
> > IMHO, it's enough two level of security. My suggestion is create a
> > bluezadmin group to
> > allow the device setup operations(write operations). Read operations
> > can be allowed to
> > bluezusers and bluezadmin. Another point is only the root can own the
> > service, I mean,
> > Only the root can run the hcid daemon.
>
> I don't see any need of having a bluezusers group. There are tasks that
> everybody can execute and I don't see any problem with it.
>
> For what do we need a special bluezadmin group? I think that the user
> should enter the root password for configuration or it should be console
> or session user.
>
> And yes, hcid will always need to be run as root.
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
