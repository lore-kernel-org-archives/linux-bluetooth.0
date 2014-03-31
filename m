Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v2 0/3] Add HDP .register_application method
Date: Mon, 31 Mar 2014 15:49:41 +0200
Message-ID: <1884435.E5HBSYUjjS@uw000953>
In-Reply-To: <1396271615-10221-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1396271615-10221-1-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 31 of March 2014 16:13:32 Ravi kumar Veeramally wrote:
> v2: Fixed Szymon's comments (response: app_id will be returned
>     in response to HAL_OP_HEALTH_REG_APP ipc command).
> v1: Fixed Szymon's comments(copy terminating character null
>     also from HAL data(names, descriptions).
> 
> RFC: Due to limited IPC_MTU and variable length of
> fields from 'bthl_reg_param_t *', it is difficult to put them
> in single command and send though IPC. So we split this command
> to multiple calls. First command will be called with opcode of
> HAL_OP_HEALTH_REG_APP with 'struct hal_cmd_health_reg_app' data.
> Later command will be called with opcode of
> HAL_OP_HEALTH_MDEP with 'struct hal_cmd_health_mdep' data for
> number_of_mdeps times. Daemon (android/health) side it will
> process after it received all data and response will be sent
> along with last call of HAL_OP_HEALTH_MDEP.
> 
> This avoids increasing value of IPC_MTU and mainly because of
> optional parameters in 'bthl_reg_param_t'. Incase of unfilled
> optional parameters, fixed size arrays in hal commands will be
> empty.
> 
> Ravi kumar Veeramally (3):
>   android/hal-ipc-api: Add extra command to Health HAL api document
>   android/hal-msg: Add extra struct for mdep data
>   android/hal-health: Add HDP .register_application method
> 
>  android/hal-health.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  android/hal-ipc-api.txt | 35 +++++++++++++--------
>  android/hal-msg.h       | 37 +++++++++++-----------
>  3 files changed, 122 insertions(+), 33 deletions(-)
>

All three patches are now upstream, thanks. 

-- 
Best regards, 
Szymon Janc
