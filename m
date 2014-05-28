Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140528102431.GA2680@aemeltch-MOBL1>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1400760367-24915-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CABBYNZLMKcj_fpSNfpHftuzWiWA=WTOotseftrBf2202iqT-PA@mail.gmail.com>
	<20140528102431.GA2680@aemeltch-MOBL1>
Date: Wed, 28 May 2014 13:32:22 +0300
Message-ID: <CABBYNZKi-Gnj7ud3Rd5RL9=50rTg4LkFq55WZUPh3jM+i9pkZg@mail.gmail.com>
Subject: Re: [RFCv0 07/14] android/hal-sco: Use global sco file descriptor
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, May 28, 2014 at 1:24 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, May 27, 2014 at 04:08:09PM +0300, Luiz Augusto von Dentz wrote:
>> Hi Andrei,
>>
>> On Thu, May 22, 2014 at 3:06 PM, Andrei Emeltchenko
>> <Andrei.Emeltchenko.news@gmail.com> wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > Android may open input/output stream independently so we use global sco
>> > file descriptor and mutexes.
>> > ---
>> >  android/hal-sco.c | 85 ++++++++++++++++++++++++++++++++-----------------------
>> >  1 file changed, 50 insertions(+), 35 deletions(-)
>> >
>> > diff --git a/android/hal-sco.c b/android/hal-sco.c
>> > index e940547..8c2549b 100644
>> > --- a/android/hal-sco.c
>> > +++ b/android/hal-sco.c
>> > @@ -46,6 +46,10 @@
>> >  static int listen_sk = -1;
>> >  static int ipc_sk = -1;
>> >
>> > +static int sco_fd = -1;
>> > +static uint16_t sco_mtu = 0;
>> > +static pthread_mutex_t sco_mutex = PTHREAD_MUTEX_INITIALIZER;
>> > +
>>
>> Do we really need a mutex for this? I mean this is almost the same as
>> protecting the device itself for opening concurrent input and output,
>> if that is the case then I think it is better to put the mutex there.
>>
>
> For some reason Android tries to open several input streams from different
> threads. So input/output streams looks might be open/closed from different
> threads.

So the device itself has to be protected otherwise you risk having more mutexes.


-- 
Luiz Augusto von Dentz
