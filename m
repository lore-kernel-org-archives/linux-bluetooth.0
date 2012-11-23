Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2254742.168381353662862601.JavaMail.weblogic@epml01>
References: <2254742.168381353662862601.JavaMail.weblogic@epml01>
Date: Fri, 23 Nov 2012 11:54:02 +0200
Message-ID: <CABBYNZ+-2YWROExMEoMxSfYTyXT1oeOpHjJECNs-xA7vtaAx_g@mail.gmail.com>
Subject: Re: Query regarding device discovery
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 23, 2012 at 11:27 AM, JAGANATH KANAKKASSERY
<jaganath.k@samsung.com> wrote:
> Hello,
>
> I have a doubt with current discovery mechanism.
>
> Suppose application 1 calls "StartDiscovery". for which "Discovering = TRUE" comes
> and then deviceFound signals starts coming.
> In the mean time application 2 calls "StartDiscovery" which will be queued in BlueZ.
> Then "discovering = FALSE" comes for the discovery initiated from application 1.
> Then as per BlueZ design, it will restart discovery for application 1 since it has not
> called "StopDiscovery" yet. So "discovering = TRUE" comes again, which application 2
> thinks that it belongs to him.
> Then if application 1 calls "StopDiscovery" immediately, discovery will be stopped
> and "Discovering = FALSE" comes with which application 2 too thinks that discovery
> initiated by him is also done.
> So eventually application 2 will not get any devices.
> So I think with current design, applications that are interested only in one complete
> inquiry session will be in trouble.
>
> So can we disable the automatic reinitiating of device discovery?
> Or is there any way to handle this scenario?


StartDiscovery doesn't queue the sessions, it actually increase the
reference to the same discovery session which became shared between
the callers, it should not interfere with the ongoing discovery nor
change how we emit Discovering. That being said the concept of one
shot inquiry is flawed since it can miss devices, with addition of LE
this is even more visible because each inquiry is only 5.12 sec., you
can still detect when an inquiry is active just check when Discovering
is TRUE and nope it should not matter if there is 1 or 20 application
listening to it once Discovery switch to TRUE we are inquiring/scan
when it switch to FALSE it has stopped and is probably doing name
resolving.

--
Luiz Augusto von Dentz
