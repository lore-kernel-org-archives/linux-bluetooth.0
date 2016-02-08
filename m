Return-Path: <chris2553@googlemail.com>
Subject: Re: 4.5 Regression - mouse not working after resume from suspend
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
References: <56B5B0C3.6050208@googlemail.com>
 <56B5DB29.9040208@googlemail.com> <56B5F2B1.5010000@googlemail.com>
 <20160206143300.GA18790@t440s.P-661HNU-F1> <56B61000.6060008@googlemail.com>
From: Chris Clayton <chris2553@googlemail.com>
Message-ID: <56B8E428.1020507@googlemail.com>
Date: Mon, 8 Feb 2016 18:53:28 +0000
MIME-Version: 1.0
In-Reply-To: <56B61000.6060008@googlemail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,


On 06/02/16 15:23, Chris Clayton wrote:
> Hi Johan,
> 

[snip]

>>  - Do you see any errors from bluetoothd when you suspend/resume?
> 

With a bit more experimenting, I find that I can re-activate the mouse by stopping and restarting bluetoothd.

The bluetooth-related messages (in /var/log/daemon.log) that are caused by the suspend to ram, resume and restarting the
daemon are:

Feb  8 18:50:17 laptop bluetoothd[4266]: Endpoint unregistered: sender=:1.34 path=/MediaEndpoint/A2DPSource
Feb  8 18:50:17 laptop bluetoothd[4266]: Endpoint unregistered: sender=:1.34 path=/MediaEndpoint/A2DPSink
Feb  8 18:50:18 laptop bluetoothd[4266]: Failed to obtain handles for "Service Changed" characteristic
Feb  8 18:50:18 laptop bluetoothd[4266]: Endpoint registered: sender=:1.34 path=/MediaEndpoint/A2DPSource
Feb  8 18:50:18 laptop bluetoothd[4266]: Endpoint registered: sender=:1.34 path=/MediaEndpoint/A2DPSink
Feb  8 18:50:31 laptop bluetoothd[4266]: Terminating
Feb  8 18:50:31 laptop bluetoothd[4266]: Endpoint unregistered: sender=:1.34 path=/MediaEndpoint/A2DPSource
Feb  8 18:50:31 laptop bluetoothd[4266]: Endpoint unregistered: sender=:1.34 path=/MediaEndpoint/A2DPSink
Feb  8 18:50:31 laptop bluetoothd[4266]: Stopping SDP server
Feb  8 18:50:31 laptop bluetoothd[4266]: Exit
Feb  8 18:50:32 laptop bluetoothd[4564]: Bluetooth daemon 5.37
Feb  8 18:50:32 laptop bluetoothd[4564]: Starting SDP server
Feb  8 18:50:32 laptop bluetoothd[4564]: Bluetooth management interface 1.11 initialized
Feb  8 18:50:32 laptop bluetoothd[4564]: Failed to obtain handles for "Service Changed" characteristic
Feb  8 18:50:32 laptop bluetoothd[4564]: Endpoint registered: sender=:1.34 path=/MediaEndpoint/A2DPSource
Feb  8 18:50:32 laptop bluetoothd[4564]: Endpoint registered: sender=:1.34 path=/MediaEndpoint/A2DPSink
Feb  8 18:50:33 laptop dbus[817]: [system] Activating service name='org.blueman.Mechanism' (using servicehelper)
Feb  8 18:50:33 laptop blueman-mechanism: Starting blueman-mechanism
Feb  8 18:50:33 laptop dbus[817]: [system] Successfully activated service 'org.blueman.Mechanism'
Feb  8 18:50:33 laptop blueman-mechanism: loading Network
Feb  8 18:50:33 laptop blueman-mechanism: loading Rfcomm
Feb  8 18:50:33 laptop blueman-mechanism: loading Ppp
Feb  8 18:50:33 laptop blueman-mechanism: loading RfKill


Maybe that will help diagnose the problem.


> Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSource
> Feb  6 15:06:24 laptop bluetoothd[888]: Endpoint unregistered: sender=:1.37 path=/MediaEndpoint/A2DPSink
> Feb  6 15:06:25 laptop bluetoothd[888]: Failed to obtain handles for "Service Changed" characteristic
> Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSource
> Feb  6 15:06:25 laptop bluetoothd[888]: Endpoint registered: sender=:1.37 path=/MediaEndpoint/A2DPSink
> 
>>  - Could you provide the HCI log from btmon for what happens when you
>>    suspend/resume (just keep btmon running over this time)
> 
> That log's a bit long, so I've attached it.
> 
> Hope this helps. Thanks
> 
> Chris
>>
>> Thanks.
>>
>> Johan
>>
