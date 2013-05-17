Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH BlueZ 1/2] test: Remove commented out code from simple-agent
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJdJm_M564tPtm5FBBxE3kDs8q8izxpOdV=S3KKw7xJe+rPk1w@mail.gmail.com>
Date: Fri, 17 May 2013 07:15:20 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BEF9B7BE-655D-4953-A514-9C7392E81C1B@holtmann.org>
References: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org> <318C0863-4CB8-4DC6-B577-13F7D33ADBF6@holtmann.org> <CAJdJm_M564tPtm5FBBxE3kDs8q8izxpOdV=S3KKw7xJe+rPk1w@mail.gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

>>> --- a/test/simple-agent
>>> +++ b/test/simple-agent
>>> @@ -176,6 +176,3 @@ if __name__ == '__main__':
>>>              manager.RequestDefaultAgent(path)
>>> 
>>>      mainloop.run()
>>> -
>>> -     #adapter.UnregisterAgent(path)
>>> -     #print("Agent unregistered")
>> 
>> I would prefer if we remove the whole script. Does it provide anything that bluetoothctl is not providing?
> 
> I have nothing against it (and we can always improve bluetoothctl if
> something is missing there), but this is a legacy script that some
> distros seem to package and users have been relying on it as a simple
> console agent. Maybe we should (somehow) advertise bluetoothctl more.
> 
> BTW, It seems that --timeout/-t option on simple-agent is totally ignored.

then lets just delete it. Distros should be shipping bluetoothctl anyway these days.

Regards

Marcel

