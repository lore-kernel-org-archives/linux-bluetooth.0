Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7BB10B.3080100@gmail.com>
Date: Sat, 12 Mar 2011 09:44:43 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>, Mikko Vinni <mmvinni@yahoo.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: re "bluetooth disabled" and "[BUG] usb problems in .38-rc3+"
References: <635561.59590.qm@web161820.mail.bf1.yahoo.com> <359639.21781.qm@web161807.mail.bf1.yahoo.com> <4D77EFEB.1020804@gmail.com> <201103092154.22796.edt@aei.ca> <20110310073206.GA1033@jh-x301> <20110312013349.GA2164@joana>
In-Reply-To: <20110312013349.GA2164@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/11/2011 05:33 PM, Gustavo F. Padovan wrote:
> * Johan Hedberg<johan.hedberg@gmail.com>  [2011-03-10 09:32:06 +0200]:
>
>> Hi,
>>
>> On Wed, Mar 09, 2011, Ed Tomlinson wrote:
>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>> index 9c4541b..f690eb5 100644
>>>> --- a/net/bluetooth/hci_core.c
>>>> +++ b/net/bluetooth/hci_core.c
>>>> @@ -95,18 +95,17 @@ void hci_req_complete(struct hci_dev *hdev, __u16
>>>> cmd, int result)
>>>>    {
>>>>    	BT_DBG("%s command 0x%04x result 0x%2.2x", hdev->name, cmd, result);
>>>>
>>>> +	if (hdev->req_status == HCI_REQ_PEND) {
>>>> +		hdev->req_result = result;
>>>> +		hdev->req_status = HCI_REQ_DONE;
>>>> +		wake_up_interruptible(&hdev->req_wait_q);
>>>> +	}
>>>>    	/* If the request has set req_last_cmd (typical for multi-HCI
>>>>    	 * command requests) check if the completed command matches
>>>>    	 * this, and if not just return. Single HCI command requests
>>>>    	 * typically leave req_last_cmd as 0 */
>>>>    	if (hdev->req_last_cmd&&  cmd != hdev->req_last_cmd)
>>>>    		return;
>>>> -
>>>> -	if (hdev->req_status == HCI_REQ_PEND) {
>>>> -		hdev->req_result = result;
>>>> -		hdev->req_status = HCI_REQ_DONE;
>>>> -		wake_up_interruptible(&hdev->req_wait_q);
>>>> -	}
>>>>    }
>>>>
>>>>    static void hci_req_cancel(struct hci_dev *hdev, int err)
>>>>
>>>
>>> Works here too - bluetooth comes up enabled.  On to Linus?
>>
>> All the patch does is it re-breaks the __hci_request function by
>> removing proper synchronization from it (again) and thereby hides the
>> real bug which is the kernel sending commands to the controller before
>> the HCI_Reset command has completed.
>
> I got an 1.1 Bluetooth dongle that can cause this issue, now I can test this
> by myself. I'll work to fix this next week.
>

cool... I am not going insane!!! let me know if you want me to test any 
patches out.

Justin P. Mattock
