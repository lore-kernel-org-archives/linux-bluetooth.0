Return-Path: <cyrus@holtmann.org>
From: Alex Fiestas <afiestas@kde.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Re: Specifying destination path in obexd/bluez-5
Date: Wed, 02 Jan 2013 11:51:08 +0100
Message-ID: <2201156.L7JLFsavcV@monsterbad>
In-Reply-To: <CABBYNZK6YAgZyxBa1a9kKFAHjy+dE7Td518CB393_9Y+RWPKkw@mail.gmail.com>
References: <13320115.C4qltrvZED@monsterbad> <CABBYNZK6YAgZyxBa1a9kKFAHjy+dE7Td518CB393_9Y+RWPKkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 31 December 2012 12:01:04 you wrote:
> Hi Alex,
> 
> On Mon, Dec 31, 2012 at 10:56 AM, Alex Fiestas <afiestas@kde.org> wrote:
> > Last time I tried to port KDE's obex support completely to obexd (we are
> > already using obexd-client for opp sendfile) I couldn't complete it
> > because
> > there is no way of programatically specify the destination path of the
> > incoming files, iirc using either ftp or opp.
> > 
> > Now checking out BlueZ-5 I'm not sure I see a way of doing it either.
> 
> There is always the possibility of using links if the underline
> filesystem support them. For OPP the agent can provide a different
> path on the return of AuthorizePush.
Oh indeed, one thing less to worry then.

> > So, is there anyway of changing the destination path programatically
> > without having to restart obexd-server? If not, can I add a wish
> > somewhere (bugrack?) for it? Would you consider?
> 
> I guess this is about FTP, right? If I understood you want to be able
> to change the folders being exported in run-time, that might be
> possible but if we do that I think it would be better to let the agent
> set its root folder once registered then you can fully control this on
> the component implementing the agent interface (usually the UI)
> leaving the command line switch only for systems without agents.
Only changing the root folder will be enough, we are already using links for 
the rest.

With that, we should be able to port KDE bluetooth support to obexd-server 
being the first step towards using BlueZ-5

Thanks !
