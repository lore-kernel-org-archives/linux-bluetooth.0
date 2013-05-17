Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BEF9B7BE-655D-4953-A514-9C7392E81C1B@holtmann.org>
References: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
	<318C0863-4CB8-4DC6-B577-13F7D33ADBF6@holtmann.org>
	<CAJdJm_M564tPtm5FBBxE3kDs8q8izxpOdV=S3KKw7xJe+rPk1w@mail.gmail.com>
	<BEF9B7BE-655D-4953-A514-9C7392E81C1B@holtmann.org>
Date: Fri, 17 May 2013 15:33:09 +0300
Message-ID: <CABBYNZ+CVJfwMRq-dmPxmzRBBovUX-o3FjSrkjLfWNfKMFH4oQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] test: Remove commented out code from simple-agent
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 17, 2013 at 8:15 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Anderson,
>
>>>> --- a/test/simple-agent
>>>> +++ b/test/simple-agent
>>>> @@ -176,6 +176,3 @@ if __name__ == '__main__':
>>>>              manager.RequestDefaultAgent(path)
>>>>
>>>>      mainloop.run()
>>>> -
>>>> -     #adapter.UnregisterAgent(path)
>>>> -     #print("Agent unregistered")
>>>
>>> I would prefer if we remove the whole script. Does it provide anything that bluetoothctl is not providing?
>>
>> I have nothing against it (and we can always improve bluetoothctl if
>> something is missing there), but this is a legacy script that some
>> distros seem to package and users have been relying on it as a simple
>> console agent. Maybe we should (somehow) advertise bluetoothctl more.
>>
>> BTW, It seems that --timeout/-t option on simple-agent is totally ignored.
>
> then lets just delete it. Distros should be shipping bluetoothctl anyway these days.

Ultimately it is better to use bluetoothctl but it doesn't hurt to
have an example in python, but we should probably improve the
documentation about agent capabilities and IMO it should default to
"KeyboardDisplay" when no capability is given (agent on), right now I
think it does "" which maps to IO_CAPABILITY_DISPLAYYESNO.

--
Luiz Augusto von Dentz
