Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <13320115.C4qltrvZED@monsterbad>
References: <13320115.C4qltrvZED@monsterbad>
Date: Mon, 31 Dec 2012 12:01:04 +0200
Message-ID: <CABBYNZK6YAgZyxBa1a9kKFAHjy+dE7Td518CB393_9Y+RWPKkw@mail.gmail.com>
Subject: Re: Specifying destination path in obexd/bluez-5
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Alex Fiestas <afiestas@kde.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Mon, Dec 31, 2012 at 10:56 AM, Alex Fiestas <afiestas@kde.org> wrote:
> Last time I tried to port KDE's obex support completely to obexd (we are
> already using obexd-client for opp sendfile) I couldn't complete it because
> there is no way of programatically specify the destination path of the
> incoming files, iirc using either ftp or opp.
>
> Now checking out BlueZ-5 I'm not sure I see a way of doing it either.

There is always the possibility of using links if the underline
filesystem support them. For OPP the agent can provide a different
path on the return of AuthorizePush.

> So, is there anyway of changing the destination path programatically without
> having to restart obexd-server? If not, can I add a wish somewhere (bugrack?)
> for it? Would you consider?

I guess this is about FTP, right? If I understood you want to be able
to change the folders being exported in run-time, that might be
possible but if we do that I think it would be better to let the agent
set its root folder once registered then you can fully control this on
the component implementing the agent interface (usually the UI)
leaving the command line switch only for systems without agents.

--
Luiz Augusto von Dentz
