Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 0/8] IPC negative tester
Date: Wed, 15 Jan 2014 17:04:04 +0100
Message-ID: <1441708.baqoOpTijl@uw000953>
In-Reply-To: <1389789757-16847-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389789757-16847-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 15 of January 2014 13:42:29 Jakub Tyszkowski wrote:
> Following patchset adds IPC negative tester framework with few test cases
> checking IPC's behaviour on daemon side. Expected daemon's behaviour is to
> shut down gracefully in case of receiving invalid IPC data.
> 
> v2 changes:
>   * fixed few indentation issues
>   * fixed missing __attribute__((packed))
>   * fixed amount of data written for 'malformed data' test case
>   * fixed opcode for 'invalid service' test case
>   * added patch(8) with more 'malformed data' cases
> 
> v3 changes:
>   * changed license to GPL
>   * changed 'ipc-negative-tester' name to 'ipc-tester'
> 
> Jakub Tyszkowski (8):
>   android/ipc-tester: Skeleton for ipc negative tester
>   android/ipc-tester: Run daemon in separate process
>   android/ipc-tester: Add IPC initialization
>   android/ipc-tester: Add daemon shutdown handler
>   android/ipc-tester: Add sending test data with ipc
>   android/ipc-tester: Register services
>   android/ipc-tester: Add basic test cases for IPC's daemon site
>   androi/ipc-tester: Add more cases for malformed data
> 
>  .gitignore           |   1 +
>  android/Makefile.am  |  17 ++
>  android/ipc-tester.c | 727 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 745 insertions(+)
>  create mode 100644 android/ipc-tester.c
> 
> --
> 1.8.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Please send V4 with changes we discussed off-line.

-- 
Best regards, 
Szymon Janc
