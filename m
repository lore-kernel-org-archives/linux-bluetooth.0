Return-Path: <cyrus@holtmann.org>
Message-ID: <53357D91.3050601@linux.intel.com>
Date: Fri, 28 Mar 2014 15:48:01 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 0/3] Add HDP .register_application method
References: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping.

On 03/25/2014 04:34 PM, Ravi kumar Veeramally wrote:
> Due to limited IPC_MTU and variable length of
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
>    android/hal-ipc-api: Add extra command to Health HAL api document
>    android/hal-msg: Add extra struct for mdep data
>    android/hal-health: Add HDP .register_application method
>
>   android/hal-health.c    | 88 ++++++++++++++++++++++++++++++++++++++++++++++++-
>   android/hal-ipc-api.txt | 34 +++++++++++--------
>   android/hal-msg.h       | 37 ++++++++++-----------
>   3 files changed, 126 insertions(+), 33 deletions(-)
>

