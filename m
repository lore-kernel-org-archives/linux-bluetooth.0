Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <318C0863-4CB8-4DC6-B577-13F7D33ADBF6@holtmann.org>
References: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
	<318C0863-4CB8-4DC6-B577-13F7D33ADBF6@holtmann.org>
Date: Thu, 16 May 2013 12:23:31 -0400
Message-ID: <CAJdJm_M564tPtm5FBBxE3kDs8q8izxpOdV=S3KKw7xJe+rPk1w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] test: Remove commented out code from simple-agent
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, May 16, 2013 at 9:45 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
>> --- a/test/simple-agent
>> +++ b/test/simple-agent
>> @@ -176,6 +176,3 @@ if __name__ == '__main__':
>>               manager.RequestDefaultAgent(path)
>>
>>       mainloop.run()
>> -
>> -     #adapter.UnregisterAgent(path)
>> -     #print("Agent unregistered")
>
> I would prefer if we remove the whole script. Does it provide anything that bluetoothctl is not providing?

I have nothing against it (and we can always improve bluetoothctl if
something is missing there), but this is a legacy script that some
distros seem to package and users have been relying on it as a simple
console agent. Maybe we should (somehow) advertise bluetoothctl more.

BTW, It seems that --timeout/-t option on simple-agent is totally ignored.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
