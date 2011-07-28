Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Jul 2011 16:12:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Santiago Carot <sancane@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/6] Proximity Monitor: Write Alert Level to
 Reporter
Message-ID: <20110728131235.GA18585@dell.ger.corp.intel.com>
References: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
 <1311803586-5405-2-git-send-email-claudio.takahasi@openbossa.org>
 <CACLukz+g-994zKLK1aPkBusEhv=ti850KhMSjGZQjJOdL9kdcw@mail.gmail.com>
 <CAKT1EBdLfwYmHQY_i4DV+aS6U_yCsKHhAv+LpojLTRpXtoNKZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAKT1EBdLfwYmHQY_i4DV+aS6U_yCsKHhAv+LpojLTRpXtoNKZw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Jul 28, 2011, Claudio Takahasi wrote:
> On Thu, Jul 28, 2011 at 1:36 AM, Santiago Carot <sancane@gmail.com> wrote:
> >> --- a/proximity/monitor.c
> >> +++ b/proximity/monitor.c
> >> @@ -35,19 +35,28 @@
> >>  #include <sys/stat.h>
> <snip>
> >> +static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
> >> +{
> >> +       struct monitor *monitor = user_data;
> >> +
> >> +       monitor->attrib = attrib;
> >
> > GAttrib is a referenciable structure. Don't you increment the
> > reference counter if you are storing an internal reference in monitor?
> 
> References are controlled by the core. The last reference for the
> GAttrib will not be release by the core until the last connection
> callback is unregistered. This is the reason why reference control
> inside the profiles are not needed. If it is more clear to everybody
> we can add reference counting in the profiles, but it will be a
> duplicated logic. Every btd_device_remove_attio_callback call will be
> followed by g_attrib_unref.

The general rule should be that you never copy a reference counted
pointer without the use of ref(). So in this case I do think it'd be
better to ref() when you copy (from attrib to monitor->attrib) and
unref() before you set to NULL.

Johan
