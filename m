Return-Path: <cyrus@holtmann.org>
From: "Xu, Martin" <martin.xu@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"martin.xu@linux.intel.com" <martin.xu@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] obex/session: Export the right target uuid
Date: Mon, 22 Jul 2013 01:59:46 +0000
Message-ID: <29981E9CC6590A438DB8A519AEB0053010D456D5@SHSMSX103.ccr.corp.intel.com>
References: <1374115110-11780-1-git-send-email-martin.xu@linux.intel.com>
 <CABBYNZLKOA6uY+J54TBP4+HtUxXvxwSy3Lb6zk5xR19iT8b9eQ@mail.gmail.com>
In-Reply-To: <CABBYNZLKOA6uY+J54TBP4+HtUxXvxwSy3Lb6zk5xR19iT8b9eQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz:
> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
> Sent: Friday, July 19, 2013 16:03
> To: martin.xu@linux.intel.com
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] obex/session: Export the right target uuid
> 
> Hi Martin,
> 
> On Thu, Jul 18, 2013 at 5:38 AM,  <martin.xu@linux.intel.com> wrote:
> > From: Martin Xu <martin.xu@linux.intel.com>
> >
> > ---
> > +       dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
> > +       g_free(uuid);
> 
> Did you ever test this? I suspect this will crash with OPP because
I did. And session_target_exists() will check the target, if it is NULL above function will not be called.
Of course, we can do more check before call target2str().
> 
> >         return TRUE;
> >  }
> > @@ -690,7 +704,7 @@ static gboolean target_exists(const
> > GDBusPropertyTable *property, void *data)  {
> >         struct obc_session *session = data;
> >
> > -       return session->driver->uuid != NULL;
> > +       return session->driver->target != NULL;
> >  }
> 
> I don't understand why you want to use the OBEX target here? There is
> no other reference to it instead we should be using what Device1.UUIDs
> provides that is Bluetooth 128 bits UUIDs in string format so the
> applications can use them directly. So I will repeat again, what needs
> to be done is reword the documentation to reflect what is implemented.
You know, the original patch send by me is just use Bluetooth 128 UUIDs.
But I found later that the client sessions is exporting the target UUIDs.
Please check code obexd/client/session.c line 690.
Target property of Client session does not need to align with Server session here?
 
> 
> And let me repeat one last time, with ObjectManager you got signaled
> what interfaces are supported, that is much more important than the
It is not related with Objectmanager, I already use that.
But with the new added interface, how could user know what kind of obex session it is?
At many cases, UI just wants to display the transfer states of OPP.

In fact, I have sent patches to proposal several suggestions:
1. just use "OPP", "FTP" for the internal supported targetUUID for external profile to decide the profile
2. do not use target UUID just use Bluetooth 128 UUID
3. use target UUID

But to very solution, at least, we need to keep the definition consistent.
