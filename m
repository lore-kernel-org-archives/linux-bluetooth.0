Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Alex Deymo <deymo@chromium.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"keybuk@chromium.org" <keybuk@chromium.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>
Subject: Re: [PATCH 0/6] The Autopair strikes back
Date: Thu, 21 Mar 2013 10:11:58 +0100
Message-ID: <3117038.DiW6TICzsh@uw000953>
In-Reply-To: <1363839008-8405-1-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Thursday 21 of March 2013 06:10:02 Alex Deymo wrote:
> Hello!
> This is a rework of the autopair.c plugin we had at some point in BlueZ 4.
> 
> The goal of this patch set is to make the pairing process easier for 
> devices that have a fixed and dumb pincode (like 0000 or 1234) or that
> accept any pincode as long as the same pincode is entered on the device
> (keyboards/combos). The goal is:
>  * Don't ask the user (i.e. the agent) a question if we know the right answer.
> This makes the user happier. =)
> 
> The covered constraints and scenarios are:
> 1. If the device has a well known pincode we should pair to it without
>    asking the agent for a pin code (no RequestPincode call). Comon case are 
>    mice and other devices with very limited input.
> 2. If the device accepts any pincode (as long as it is also entered in the
>    device), we should provide the agent a random pincode (calling
>    DisplayPincode) avoiding the unnecessary step of asking the agent for a
>    [random] pincode (with RequestPincode). Comon case are keyboards/combos.
> 3. Don't return a failed error because we failed to guess the pincode. Retry
>    instead until is not our fault (i.e., the device is out of range, the
>    agent provided a wrong code, etc)
> 4. If the device accepts only a fixed pincode (and we don't know it) we
>    should ask the agent for the pincode and be able to pair with the device.
>    Read this as: don't break any compatibility.
> 
> The implemented logic is:
> For each new org.bluez.Device1.Pair call that ends in a pin request (not SSP)
> we *iterate* the list of pincode callbacks from plugins trying every callback
> until it returns 0 (no pincode). For each pincode in this iteration, we try
> to use it for the pin request. If it fails with an auth_failed, then we try
> again with the next one until we reach the end of the list.

I think 'repeated attempts' error should be covered e.g. retry with current
one after some timeout.

> When we reach the end of the list, we try again but this time asking the
> agent, thus following the current normal course (i.e. failing if there isn't
> an agent registered, etc).
> 
> I'm open to hear your comments and look forward to have this patch set in.
> If you find a problem or a device that doesn't work with this patch, please
> let me know.

I have a vague plan to make neard plugin not limited to pairing only and do
other actions depending on device cod/uuids so maybe it would make sense to
not use hardcoded magic numbers in autopair plugin and provide some generic
code for testing major/minor cod number?

-- 
BR
Szymon Janc
