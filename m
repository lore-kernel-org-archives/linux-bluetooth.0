Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJNxEnKk-E5TcSwwNwkeBDhbsBgyMUJ_MuL02-MeV_i1Q@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
 <CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
 <CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com> <CABBYNZJNxEnKk-E5TcSwwNwkeBDhbsBgyMUJ_MuL02-MeV_i1Q@mail.gmail.com>
From: Alex Deymo <deymo@chromium.org>
Date: Fri, 10 May 2013 18:51:20 -0700
Message-ID: <CAGd9gwj7c=EL8bQ_qjEq7XR5LonH_c=sQyTrhvnxompiN687Vg@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 10, 2013 at 1:09 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Yes, you should release the fd once the state change to idle, in the
> future we might actually use frevoke (http://lwn.net/Articles/192632/)
> to revoke the permissions but for now we have to assume the endpoint
> will behave and close whenever the transport became idle. You are also
> right, we should probably update the documentation to state the fd is
> considered revoked in this case and the endpoint has to acquired
> again. Btw PulseAudio does that already so Im curious why you are not
> using PA, or is this for another Audio daemon?

Oh, thank you very much for that information. I would never guessed
that was the problem!
Having the documentation clear and updated is good not only because
not everyone uses PA, but also because definitively we don't want to
use PA for testing (we may want to fake and control the interaction
with the audio server to run a test). Actually, as Scott mentioned we
are not using PA on Chromium/ChromiumOS laptops, we are using CRAS
(ChromeOS Audio Server) which is basically the minimum we need to have
low latency dynamic audio routing with a low CPU impact... and that's
basically the "why". If you are curious, you can find the original
design doc here [1], the code is opensource and here [2] and actually
also works on ubuntu [3], but need applications (like chrome) that
know how to talk with cras.

Again, thanks for the help.
Alex.

[1] http://www.chromium.org/chromium-os/chromiumos-design-docs/cras-chromeos-audio-server
[2] http://git.chromium.org/gitweb/?p=chromiumos/third_party/adhd.git;a=summary
[3] http://www.chromium.org/chromium-os/how-tos-and-troubleshooting/chrome-with-libcras-on-gprecise
