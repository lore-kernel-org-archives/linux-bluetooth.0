Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Hedberg, Johan" <johan.hedberg@intel.com>
Subject: RE: obexd questions
Date: Wed, 10 Apr 2013 08:46:36 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E1089B253@SHSMSX102.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E1089AB8A@SHSMSX102.ccr.corp.intel.com>
 <CABBYNZLppgXMV3+4GXE8r-pC5KS5ufcRYqd8yhXGNhHCW5g5YA@mail.gmail.com>
In-Reply-To: <CABBYNZLppgXMV3+4GXE8r-pC5KS5ufcRYqd8yhXGNhHCW5g5YA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Thanks

Best Regards
Zheng Wu

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org
> [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von
> Dentz
> Sent: Wednesday, April 10, 2013 4:29 PM
> To: Zheng, Wu
> Cc: linux-bluetooth@vger.kernel.org; Von Dentz, Luiz; Hedberg, Johan
> Subject: Re: obexd questions
> 
> Hi,
> 
> On Wed, Apr 10, 2013 at 7:15 AM, Zheng, Wu <wu.zheng@intel.com> wrote:
> > Hi,
> >
> > I meet some questions to use bluez's OPP profiles. Please help.
> >
> > 1. When opp client sends files and opp server receives files, opp client and opp
> server uses the same transfer dbus name "org.bluez.obex.Transfer1" .
> 
> org.bluez.obex.Transfer1 is the interface name not the bus name which is fine to
> be reused, objects path in the other hand cannot be reused.
> 
> > How can application know the transfer is sending file or receiving file?
> 
> There is no property for transfer direction although the application starting the
> transfer should know about it we should probably add a property that have this
> info.
> 
> > Can the different transfer dbus names be used for opp client and opp server?
> 
> There is only one bus name, org.bluez.obex, what I think you are referring to is
> having different session/transfer object paths, that is something I just realize
> needs fixing since server and client code are not aware of each other sessions
> and transfers.
> 
> 
> > 2. I check the function of "create_session" in obexd/client/Manager.c in Bluez.
> >
> > When session creates successfully, "create_session" returns NULL.
> >
> > I can't get session info (such as session path and so on) after "create_session".
> >
> > Is it right? Thanks.
> 
> create_session returns NULL because it is async, we reply on create_callback, but
> that is not a problem, the real problem is that objects path from client and server
> can clash and that is a bug.
> 
> 
> --
> Luiz Augusto von Dentz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
