Return-Path: <cyrus@holtmann.org>
Message-ID: <518B62E6.1040905@asianux.com>
Date: Thu, 09 May 2013 16:48:38 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Jiri Kosina <jkosina@suse.cz>
CC: Gustavo Padovan <gustavo@padovan.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 David Miller <davem@davemloft.net>, andrei.emeltchenko@intel.com,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: hidp: using strlcpy instead of strncpy,
 also beautify code.
References: <518906A8.7060708@asianux.com> <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com> <5189A417.503@asianux.com> <5189C7C6.8090408@asianux.com> <alpine.LNX.2.00.1305091041140.23038@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1305091041140.23038@pobox.suse.cz>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/09/2013 04:42 PM, Jiri Kosina wrote:
> On Wed, 8 May 2013, Chen Gang wrote:
> 
>> > 
>> > For NUL terminated string, need always let it ended by zero.
>> > 
>> > Since have already called memcpy() to initialize 'ci', so need not
>> > redundent initializations.
>> > 
>> > Better use ''if(session->hid) {} else if(session->input) {}'' instead
>> > of ''if(session->hid) {}; if(session->input) {};''
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Makes sense.
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 
> Gustavo, going to take this, please?
> 
> -- Jiri Kosina SUSE Labs
> 

Thanks, and also help to fix the spelling: redundent -> redundant.
(if need let me send patch v3, please reply to tell me, thanks)


-- 
Chen Gang

Asianux Corporation
