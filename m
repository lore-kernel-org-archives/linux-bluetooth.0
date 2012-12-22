Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGXs5wXEEnO084sg1Er-SgB3-TU+W5HtjsKnY7CdT9Hsw+jjew@mail.gmail.com>
References: <CAGXs5wXEEnO084sg1Er-SgB3-TU+W5HtjsKnY7CdT9Hsw+jjew@mail.gmail.com>
Date: Sat, 22 Dec 2012 19:22:15 +0200
Message-ID: <CAGXs5wX3_b6FeDeuMA88wfsUwAWjQ23OXrcL5QbfrhE+BTKOBg@mail.gmail.com>
Subject: Re: setting BT connection over RFCOMM
From: Kevin Wilson <wkevils@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
Please ignore my question. It turns out that
 CONFIG_BT_RFCOMM_TTY was not set.
As a result, there was an error on the server
which prevented connection establishment,
Now after setting CONFIG_BT_RFCOMM_TTY,
it works.

rgs
Kevin


On Sat, Dec 22, 2012 at 6:48 AM, Kevin Wilson <wkevils@gmail.com> wrote:
> connect rfcomm0
