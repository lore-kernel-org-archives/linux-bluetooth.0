Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Feb 2011 17:11:23 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Move HealthManager Interface to "/" path
Message-ID: <20110215201123.GC7219@joana>
References: <1297798306-32591-1-git-send-email-padovan@profusion.mobi>
 <9C50502C-696A-45DE-B306-8421FE18F897@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <9C50502C-696A-45DE-B306-8421FE18F897@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Elvis Pfützenreuter <epx@signove.com> [2011-02-15 17:45:05 -0200]:

> Hi Padovan,
> 
> On Feb 15, 2011, at 5:31 PM, Gustavo F. Padovan wrote:
> 
> > Yeah, this breaks the API, but health is still disabled by default and it
> > is not a good idea create a new path only for it. So moving it to "/"
> > ---
> > doc/health-api.txt    |    2 +-
> > health/hdp.c          |    4 ++--
> > test/test-health      |    2 +-
> > test/test-health-sink |    2 +-
> > 4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/doc/health-api.txt b/doc/health-api.txt
> > index 3d0a717..9d5a54d 100644
> > --- a/doc/health-api.txt
> > +++ b/doc/health-api.txt
> > @@ -10,7 +10,7 @@ Health Device Profile hierarchy
> > 
> > Service		org.bluez
> > Interface	org.bluez.HealthManager
> > -Object path	/org/bluez/
> > +Object path	/
> > 
> > Methods:
> > 
> > diff --git a/health/hdp.c b/health/hdp.c
> > index d4a2a30..e58bd55 100644
> > --- a/health/hdp.c
> > +++ b/health/hdp.c
> > @@ -2171,7 +2171,7 @@ int hdp_manager_start(DBusConnection *conn)
> > {
> > 	DBG("Starting Health manager");
> > 
> > -	if (!g_dbus_register_interface(conn, MANAGER_PATH,
> > +	if (!g_dbus_register_interface(conn, "/",
> 
> I'd rather change macro value instead of removing it. Patch gets smaller. 
> (Or remove the macro definition along with its references.)

Yeah, I forgot to remove the macro definition.

-- 
Gustavo F. Padovan
http://profusion.mobi
