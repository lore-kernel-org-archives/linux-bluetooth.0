Return-Path: <cyrus@holtmann.org>
Message-ID: <518AF6BE.1@asianux.com>
Date: Thu, 09 May 2013 09:07:10 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 David Miller <davem@davemloft.net>,
 Jiri Kosina <jkosina@suse.cz>, andrei.emeltchenko@intel.com,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: hidp: using strlcpy instead of strncpy,
 also beautify code.
References: <518906A8.7060708@asianux.com> <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com> <5189A417.503@asianux.com> <5189C7C6.8090408@asianux.com> <CANq1E4Q+duvLzwmwN=FHb2AaTQsnSgxRD7T+YsBZLSE-kchR_Q@mail.gmail.com>
In-Reply-To: <CANq1E4Q+duvLzwmwN=FHb2AaTQsnSgxRD7T+YsBZLSE-kchR_Q@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/08/2013 11:16 PM, David Herrmann wrote:
> On Wed, May 8, 2013 at 5:34 AM, Chen Gang <gang.chen@asianux.com> wrote:
>> >
>> > For NUL terminated string, need always let it ended by zero.
>> >
>> > Since have already called memcpy() to initialize 'ci', so need not
>> > redundent initializations.
>> >
>> > Better use ''if(session->hid) {} else if(session->input) {}'' instead
>> > of ''if(session->hid) {}; if(session->input) {};''
> Yep, looks good now.
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks.

-- 
Chen Gang

Asianux Corporation
