Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5303720B.4090902@convergeddevices.net>
References: <53026C2F.4010705@convergeddevices.net>
	<5303720B.4090902@convergeddevices.net>
Date: Tue, 18 Feb 2014 18:27:08 +0200
Message-ID: <CABBYNZL_+TUf22wApCgb40a-bPWtUZq2jKUT9eVZ9KAOz8MfQw@mail.gmail.com>
Subject: Re: Help with AVDTP Connection accept
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: tony <tony.makkiel@convergeddevices.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tony,

On Tue, Feb 18, 2014 at 4:45 PM, tony <tony.makkiel@convergeddevices.net> wrote:
> A2DP sdp record is not enabled by default. Once I added the source service
> using sdptool, I can get past the 'AVDTP CONNECT'. But now it cribs at AVDTP
> DISCOVER. Any ideas?
>
> Thanks,
> Tony
>
>
>
> On 17/02/14 20:08, tony wrote:
>>
>> Hi,
>>          I have BlueZ 4.101 and the daemon is running(log file
>> daemon.txt). I am trying to initiate an AVDTP connection from PTS suite.
>> But couldn't get(or not sure how) the BlueZ side accept the connection.
>>  From the log I can see the device reply with no Link key message. But
>> the connection gets dropped quickly.
>>
>> 1) From browsing the SDP entries (log :- sdptool.txt ), I don't see an
>> entry for A2DP. I ran the configure file with --enable audio and can see
>> from the daemon.txt audio plugin is loaded. Should I be adding SDP
>> record manually? How can I do that?
>>
>> 2) Am I right in understanding, I should be using test/simple-agent to
>> manage SSP? At present I don't see anything. From forums, I understand,
>> the script would prompt for PIN or any security as required. But in my
>> case nothing happens.  I have attached the btmon log as well.
>>
>> Thank you for any pointers or suggestions.

I suspect you don't have a endpoint registered in your system, you can
either use test/simple-endpoint or PulseAudio as endpoint or create
one yourself. The so called endpoint is required since bluetoothd
don't deal with the audio streams so normally this is part of the
platform integration where the audio/media server need to take over.
