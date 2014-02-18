Return-Path: <cyrus@holtmann.org>
Message-ID: <5303720B.4090902@convergeddevices.net>
Date: Tue, 18 Feb 2014 14:45:31 +0000
From: tony <tony.makkiel@convergeddevices.net>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Re: Help with AVDTP Connection accept
References: <53026C2F.4010705@convergeddevices.net>
In-Reply-To: <53026C2F.4010705@convergeddevices.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A2DP sdp record is not enabled by default. Once I added the source 
service using sdptool, I can get past the 'AVDTP CONNECT'. But now it 
cribs at AVDTP DISCOVER. Any ideas?

Thanks,
Tony


On 17/02/14 20:08, tony wrote:
> Hi,
>          I have BlueZ 4.101 and the daemon is running(log file
> daemon.txt). I am trying to initiate an AVDTP connection from PTS suite.
> But couldn’t get(or not sure how) the BlueZ side accept the connection.
>  From the log I can see the device reply with no Link key message. But
> the connection gets dropped quickly.
>
> 1) From browsing the SDP entries (log :- sdptool.txt ), I don't see an
> entry for A2DP. I ran the configure file with --enable audio and can see
> from the daemon.txt audio plugin is loaded. Should I be adding SDP
> record manually? How can I do that?
>
> 2) Am I right in understanding, I should be using test/simple-agent to
> manage SSP? At present I don’t see anything. From forums, I understand,
> the script would prompt for PIN or any security as required. But in my
> case nothing happens.  I have attached the btmon log as well.
>
> Thank you for any pointers or suggestions.
>
> Thanks,
> Tony
