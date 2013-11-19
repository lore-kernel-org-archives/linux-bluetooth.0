Return-Path: <cyrus@holtmann.org>
Message-ID: <528B6CFA.5080304@linux.intel.com>
Date: Tue, 19 Nov 2013 15:51:54 +0200
From: Ravi Kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] android/hal-pan: Return error in case of unsupported
 PAN roles
References: <1384863676-12358-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1384863676-12358-2-git-send-email-ravikumar.veeramally@linux.intel.com> <20131119132753.GB30863@x220.p-661hnu-f1>
In-Reply-To: <20131119132753.GB30863@x220.p-661hnu-f1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 11/19/2013 03:27 PM, Johan Hedberg wrote:
> Hi Ravi,
>
> On Tue, Nov 19, 2013, Ravi kumar Veeramally wrote:
>> ---
>>   android/hal-pan.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/android/hal-pan.c b/android/hal-pan.c
>> index 2bc560e..30facd4 100644
>> --- a/android/hal-pan.c
>> +++ b/android/hal-pan.c
>> @@ -77,6 +77,9 @@ static bt_status_t pan_enable(int local_role)
>>   	if (!interface_ready())
>>   		return BT_STATUS_NOT_READY;
>>   
>> +	if (!(local_role == BTPAN_ROLE_PANU || local_role == BTPAN_ROLE_PANNAP))
>> +		return BT_STATUS_UNSUPPORTED;
>> +
>>   	cmd.local_role = local_role;
>>   
>>   	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
>> @@ -112,6 +115,14 @@ static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
>>   	if (!interface_ready())
>>   		return BT_STATUS_NOT_READY;
>>   
>> +	if (!((local_role == BTPAN_ROLE_PANNAP &&
>> +			remote_role == BTPAN_ROLE_PANU) ||
>> +		(local_role == BTPAN_ROLE_PANU &&
>> +			remote_role == BTPAN_ROLE_PANNAP) ||
>> +		(local_role == BTPAN_ROLE_PANU &&
>> +			remote_role == BTPAN_ROLE_PANU)))
>> +		return BT_STATUS_UNSUPPORTED;
> First of all you've got incorrect indentation here which make this hard
> to read (the return statement being on the same column as parts of the
> if-statement. When you break lines indent at least by two tabs to make
> a clear separation from the actual branch code.
   Ok.
>
> Secondly, shouldn't we be checking that the given local role has been
> enabled (through pan_enable)? Or does the daemon do that checking? In
> fact is there a clear reason not to let the daemon do all the
> verification checks and return an error status over IPC?
   I thought it would be easier to do basic checks on supported combinations
  at HAL level  to reduce the ipc traffic.
  I don't know exactly whether UI can send these combinations, but we 
can at least
try with haltest tool.
>
> Thirdly, this if-statement takes a while to parse, so I'm wondering
> whether it'd be clearer to format it in a bit more readable way, e.g.:
>
>          switch (local_role) {
>          case BTPAN_ROLE_PANNAP:
>                  if (remote_role != BTPAN_ROLE_PANU)
>                          return BT_STATUS_UNSUPPORTED;
>                  break;
>          case BTPAN_ROLE_PANU:
>                  if (remote_role != BTPAN_ROLE_PANNAP &&
>                                                  remote_role != BTPAN_ROLE_PANU)
>                          return BT_STATUS_UNSUPPORTED;
>                  break;
>          default:
>                  return BT_STATUS_UNSUPPORTED;
>          }
>
> Thoughts?
   Yes, make sense to use 'switch' for more readability.
   Is it ok to send _v2 with switch or better to handle in daemon?

  Thanks,
  Ravi.
