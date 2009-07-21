Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6256373e$7df40b29$569f21c8$@com>
References: <6256373e$7df40b29$569f21c8$@com>
Date: Tue, 21 Jul 2009 15:02:04 -0300
Message-ID: <2d5a2c100907211102v4228012h2bc226cceb12abc3@mail.gmail.com>
Subject: Re: sdp update record
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: josem@robleshermoso.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 20, 2009 at 5:46 AM,
josem@robleshermoso.com<josem@robleshermoso.com> wrote:
> Hi everyone
>
> Working with BlueZ 4.46, bluetoothd process makes an segfault when an
> "update sdp record" request is processed. Running with valgrind memcheck
> I checked that when an "search attr" request arrives after the "update sdp
> record",
>  this record handle not exists because this memory has been freed in the
> "update sdp record" stage. The code block when "update spd record" is made
>

Thanks for reporting this, a patch has been pushed upstream to solve this:

http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=8c677a559dbaa7c9b53fea05f91081c05244ec1f

Note that nrec should reuse the memory from orec thus the assert.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
