Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOR4+gJGyU2Fh1bRq85kaJcdD5Ranc1uEutSmbtDBZvF4uo_7w@mail.gmail.com>
References: <1384872988-19914-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1384872988-19914-2-git-send-email-ravikumar.veeramally@linux.intel.com>
	<CAOR4+gJGyU2Fh1bRq85kaJcdD5Ranc1uEutSmbtDBZvF4uo_7w@mail.gmail.com>
Date: Wed, 20 Nov 2013 11:09:00 +0200
Message-ID: <CABBYNZKcfw7eAvfEGt=jVoJ7XHGkDYtGwE4bC1tbApe_BasfAw@mail.gmail.com>
Subject: Re: [PATCH_v2 2/4] android: Handle multiple init(register) and
 cleanup(unregister) calls properly
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Nov 20, 2013 at 9:02 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Hi Ravi,
>
> On Tue, Nov 19, 2013 at 3:56 PM, Ravi kumar Veeramally
> <ravikumar.veeramally@linux.intel.com> wrote:
>> This can be tested with haltest.
>
> I think this should be already handled by Core service. Were you able
> to get success response from daemon on multiple sequent init or
> cleanup calls?
>
> btw: I think we should fix this on hal side as well, currently only
> bluetooth hal is handling error from daemon correctly. There is also
> question if we should return success on second init call...

I would just return success if init was already called and should
probably be done in a central place, perhaps in the HAL side.


-- 
Luiz Augusto von Dentz
