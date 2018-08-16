Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <a7c1bf51-751c-880a-56b9-c730d2f0ca7f@valdikss.org.ru>
In-Reply-To: <a7c1bf51-751c-880a-56b9-c730d2f0ca7f@valdikss.org.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Aug 2018 22:53:38 +0300
Message-ID: <CABBYNZKFSZz-iWE6wrph=DtJM=N+Y2vFF3uP7eZwZkwu2NJQSA@mail.gmail.com>
Subject: Re: [Question] Bluetooth SBC codec bitpool/bitrate limitations
To: ValdikSS <iam@valdikss.org.ru>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On Thu, Aug 16, 2018 at 9:45 PM ValdikSS <iam@valdikss.org.ru> wrote:
>
> Hello. I'm researching A2DP lately and I don't know anybody who deeply un=
derstands Bluetooth and Bluetooth codecs, hope you don't mind my questions.
>
> A lot of people on the internet complain about SBC audio quality. Not all=
 headphones negotiate high bitpool values, which usually leads to more or l=
ess distorted high frequencies.
>
> Almost all of the time in my tests with laptop, smartphones and different=
 headphones, SBC was negotiated with the following parameters: 8 subbands, =
16 blocks, 53 max bitpool value. These parameters give 328 kbit/s bitrate f=
or 44.1 kHz, 345 kbit/s for 48 kHz. While these parameters produce pretty d=
ecent audio, you can clearly see 17 kHz cutoff due to lack of free quantiza=
tion bytes for higher frequencies. The majority of headsets have 53 max bit=
pool value.
>
> I'm confused of bitpool. After reading A2DP specification, SBC RTP incaps=
ulation RFC and some other documents, I still can't understand why it was d=
ecided to use bitpool and not bitrate in the codec parameters negotiation p=
rocess. It doesn't describe maximum bitrate constraints and limits maximum =
possible audio quality because it's not bound to other codec parameters, wh=
ich have a lot of influence on the bitrate. You can almost double the bitra=
te by using dual_channel instead of stereo/joint stereo, or set 4 subbands =
for stereo, with the same max bitpool value, and get higher audio quality/b=
itrate.
>
> By patching pulseaudio, I was able to use 4 subbands dual_channel SBC wit=
h my headphones with 730+ kbit/s overall bitrate, much higher compared to s=
tock 328 kbit/s for 44.1 kHz 51 max bitpool value from the specification. A=
udio is full bandwidth now, and not cut off at 17 kHz, and I'm still not ex=
ceeding maximum bitpool value supported by the headphones (Overdrive RealFo=
rce D1, CSR chipset).
>
>
> Interesting that android bluetooth stack (bluedroid) operates with bitrat=
e. It has bitpool constraints (max 53) and bitrate constraints (max 328, ev=
en for 48 kHz), and it won't use e.g. bitpool 53 with 48 kHz (as pulseaudio=
 do on my headphones), but would downgrade it to 51 to fit it into 328 kbit=
/s. With a patched Android Bluetooth stack, I was able to use 660 kbit/s SB=
C audio on an old Android phone with Bluetooth 2.1 without any problems.
>
>
> A2DP v1.2 specification states the following:
>
> >The decoder of the SNK shall support all possible bitpool values that do=
 not result in excess of the maximum bit rate. This profile limits the avai=
lable maximum bit rate to 320kb/s for mono, and 512kb/s for two-channel mod=
es.
>
> Current version of the specification does not have this statement, but co=
ntains the following:
>
> >A SNK device may support bitpools larger than the High Quality value in =
Table 4.7, but shall be required to demonstrate the ability to acceptably r=
ender the resulting media.
>
> As far as I understand, A2DP v1.2 compatible decoders should support bitr=
ates up to 512 kbit, and the following profile is valid for them: DUAL_CHAN=
NEL, 8 subbands, 16 blocks, 43 max bitpool, which results in 507 kbit/s bit=
rate.
>
> The majority of the headphones set bitpool max to 53, but there are some =
with 80 or even 250 values. For example:
> Beats Solo=C2=B3: bitpool: 2..250
> JBL Everest Elite 750NC: bitpool 10..80
>
>
> To me it feels that bitpool should be an internal variable. Is it a speci=
fication design fault that bitpool value is not bound to other codec parame=
ters and only defined as a global value, or am I missing something? Do you =
have an idea why all current bluetooth stacks prefer, for example, joint st=
ereo and not dual_channel with twice the bitrate? Would it be safe to switc=
h current implementations to use dual_channel with bitrate limit of 512 kbi=
t/s?

The reason of 53 bitpool is probably due to the spec. suggesting it as
high quality, which as you said is not quite right, so BlueZ never
really imposed any limitation on what you can configure, even going
above 512 kbit/s. As for not using dual channel that is known to
consume more bandwidth which may have an impact on airtime and
coexisting with wifi which is why joint stereo is preferred, the real
problem I would say is limiting to just 53 especially because the
bitpool can be adjusted on the fly so this is on the headset
manufacturers, perhaps because they actually want SBC to be perceived
as a bad codec so user would favor their proprietary codec? Or perhaps
because SBC has a quite bad compression rate and latency compared to
other codecs, still there is no reason to limit the bitpool.

--=20
Luiz Augusto von Dentz
