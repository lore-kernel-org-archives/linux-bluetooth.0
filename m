Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLf7JANb+QxKWczvQNeG1DvqYkbbD9_nncdfznCajLOWg@mail.gmail.com>
References: <CAGd9gwjqSiH3=JwR80VcuXf2Z7KA8zOsYFT9N5gAZgZnTfF2wQ@mail.gmail.com>
	<CABBYNZ+dE7Pkt5-RpzQQ1YSgj9pa4cM+MMDwGKFmdidApDtUKQ@mail.gmail.com>
	<CAGd9gwi=72xSK5=ne2+wPU-A=oEz2VXnpPqjxMW9Z6OnyHOUMA@mail.gmail.com>
	<CABBYNZJNxEnKk-E5TcSwwNwkeBDhbsBgyMUJ_MuL02-MeV_i1Q@mail.gmail.com>
	<CAGd9gwj7c=EL8bQ_qjEq7XR5LonH_c=sQyTrhvnxompiN687Vg@mail.gmail.com>
	<CABBYNZLf7JANb+QxKWczvQNeG1DvqYkbbD9_nncdfznCajLOWg@mail.gmail.com>
Date: Wed, 15 May 2013 08:33:45 -0700
Message-ID: <CAHZ1yCmMOyYiBYO2Fg8SRc_9h-_3Jw=74mAuvucZJUrVm76ieA@mail.gmail.com>
Subject: Re: Audio sink stream remains suspended on reconnection
From: Scott James Remnant <keybuk@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Alex Deymo <deymo@chromium.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's still not fully clear to me how the state could be handled. For
example, the following:

We only acquire the transport stream when we have actual sound to be
played, and once we've finished playback we release the transport
stream again. In most circumstances this seems correct, and matches
what we see on other platforms - with a suspend being sent to the
device, and a start being sent when we have more sound to play.

What I can't figure out is what we're supposed to do in the case where
the device sends the start (state goes to pending) when we _don't_
have any sound to play.

Are we still expected to acquire the transport stream? What happens if we don't?

Scott

On Mon, May 13, 2013 at 10:04 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Alex,
>
> On Sat, May 11, 2013 at 4:51 AM, Alex Deymo <deymo@chromium.org> wrote:
>> Hi Luiz,
>>
>> On Fri, May 10, 2013 at 1:09 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Yes, you should release the fd once the state change to idle, in the
>>> future we might actually use frevoke (http://lwn.net/Articles/192632/)
>>> to revoke the permissions but for now we have to assume the endpoint
>>> will behave and close whenever the transport became idle. You are also
>>> right, we should probably update the documentation to state the fd is
>>> considered revoked in this case and the endpoint has to acquired
>>> again. Btw PulseAudio does that already so Im curious why you are not
>>> using PA, or is this for another Audio daemon?
>>
>> Oh, thank you very much for that information. I would never guessed
>> that was the problem!
>> Having the documentation clear and updated is good not only because
>> not everyone uses PA, but also because definitively we don't want to
>> use PA for testing (we may want to fake and control the interaction
>> with the audio server to run a test). Actually, as Scott mentioned we
>> are not using PA on Chromium/ChromiumOS laptops, we are using CRAS
>> (ChromeOS Audio Server) which is basically the minimum we need to have
>> low latency dynamic audio routing with a low CPU impact... and that's
>> basically the "why". If you are curious, you can find the original
>> design doc here [1], the code is opensource and here [2] and actually
>> also works on ubuntu [3], but need applications (like chrome) that
>> know how to talk with cras.
>
> If you fill that you can put some effort in improving the
> documentation patches are welcome, I hope now it is clear how the
> state should handled, you can still overwrite and request to resume by
> doing Acquire but the remote stack may refuse to do so, it is actually
> recommended that whoever suspend should resume.
>
> Regarding PulseAudio, it is a bit frustrating to see very little
> effort for adapting PA for whatever you guys need and btw Arun did
> ported PA to Android and compared it with AudioFlinger:
>
> http://arunraghavan.net/2012/01/pulseaudio-vs-audioflinger-fight/
>
> It doesn't look like PA is power hog, it can get low latency as well,
> anyway it is probably not a good idea to talk about this in
> linux-bluetooth, there are very competent guys in PA mailing list to
> discuss about this.
