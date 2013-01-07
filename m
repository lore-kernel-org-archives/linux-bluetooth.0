Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1356630354.19248.58.camel@aeonflux>
References: <1356615418-4351-1-git-send-email-s.syam@samsung.com>
	<1356615418-4351-2-git-send-email-s.syam@samsung.com>
	<1356630354.19248.58.camel@aeonflux>
Date: Tue, 8 Jan 2013 02:17:16 +0530
Message-ID: <CAFBvHie9PzNgB9Ju-Q7aFJAR+g+A5Z_aWGOHVRXxcWG7J=mjwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Update management interface revision
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Syam Sidhardhan <s.syam@samsung.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 27, 2012 at 11:15 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Syam,
>
>> This enable us to introduce a check in user space to know
>> whether it's safe to pass non-16bit UUID's to kernel or not.
>> Currently the kernel support only 16bit UUID's in the EIR.
>>
>> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
>> ---
>>  net/bluetooth/mgmt.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> NAK. As I said before, I want the kernel to support 32-bit and 128-bit
> UUIDs. There is no point in doing a minimal fix. I want to see this
> fixed properly.

Ok, I'll send the 32-bit and 128-bit support patches soon.

Thanks,
Syam
