Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <01ff01d09869$a3ee35f0$ebcaa1d0$@samsung.com>
References: <1427692567-631-1-git-send-email-bharat.panda@samsung.com>
	<004101d06b73$9289a650$b79cf2f0$@samsung.com>
	<CABBYNZ+wrVLJen3F1Wxx==syH325RwgUL9OcGc6ygtiwhceDkw@mail.gmail.com>
	<01ff01d09869$a3ee35f0$ebcaa1d0$@samsung.com>
Date: Wed, 27 May 2015 15:01:32 +0300
Message-ID: <CABBYNZLXSgD6Uyofx_BAB5oQTon3T87MgXLu+FL82Cb7sMWLyQ@mail.gmail.com>
Subject: Re: [PATCH v4] monitor: Add AVDTP support to btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Wed, May 27, 2015 at 1:41 PM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Tuesday, March 31, 2015 6:57 PM
>> To: Bharat Bhusan Panda
>> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
>> Subject: Re: [PATCH v4] monitor: Add AVDTP support to btmon
>>
>> Hi Bharat,
>>
>> On Tue, Mar 31, 2015 at 8:28 AM, Bharat Bhusan Panda
>> <bharat.panda@samsung.com> wrote:
>> > ping
>>
>> Looks like it would be a problem for multiple devices connected since at
>> assign_scid we don't have the information about the device just the psm?
>> Did you try that?
> Did you mean, multiple devices connected to same AVDTP case?

Yep, if lets say a second device connects to AVDTP it would cause num
to be increased since it is the same psm and that would break the
parsing. If we want to track this properly we need to add the remote
device to l2cap_frame so we only increment num if the device matches.


-- 
Luiz Augusto von Dentz
