Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1384872988-19914-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384872988-19914-1-git-send-email-ravikumar.veeramally@linux.intel.com>
	<1384872988-19914-2-git-send-email-ravikumar.veeramally@linux.intel.com>
Date: Wed, 20 Nov 2013 08:02:01 +0100
Message-ID: <CAOR4+gJGyU2Fh1bRq85kaJcdD5Ranc1uEutSmbtDBZvF4uo_7w@mail.gmail.com>
Subject: Re: [PATCH_v2 2/4] android: Handle multiple init(register) and
 cleanup(unregister) calls properly
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Tue, Nov 19, 2013 at 3:56 PM, Ravi kumar Veeramally
<ravikumar.veeramally@linux.intel.com> wrote:
> This can be tested with haltest.

I think this should be already handled by Core service. Were you able
to get success response from daemon on multiple sequent init or
cleanup calls?

btw: I think we should fix this on hal side as well, currently only
bluetooth hal is handling error from daemon correctly. There is also
question if we should return success on second init call...

-- 
BR
Szymon Janc
