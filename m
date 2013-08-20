Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1376923727-12152-1-git-send-email-luiz.dentz@gmail.com>
References: <1376923727-12152-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 19 Aug 2013 21:01:44 -0300
Message-ID: <CAMOw1v6d1PTZpQ=81MgJjYOy23giRobneYehLUubPhV28Zm50Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] build: Fix not rebuilding bluetoothd if gdbus changes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 19, 2013 at 11:48 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> src_bluetoothd_DEPENDENCIES should list all local libraries including gdbus
> otherwise it does not get recompiled whenever gdbus changes.

relinked, not recompiled

Lucas De Marchi
