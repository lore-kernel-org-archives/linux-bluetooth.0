Return-Path: <wb0gaz@hotmail.com>
From: David Feldman <wb0gaz@hotmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, wb0gaz@hotmail.com
Date: Tue, 22 Jun 2004 09:20:50 -0600
Subject: Re: [Bluez-users] How is pairing completed in rfcomm?
In-Reply-To: <1087852135.4328.30.camel@pegasus>
References: <20040621135136.7C703C50.wb0gaz@hotmail.com> <1087852135.4328.30.camel@pegasus>
Message-Id: <20040622092050.AAF4DB00.wb0gaz@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel/List:

I have made more progress!

It is not working, but I think I am now close. I still cannot 
complete pairing.

I did not realize that it was necessary to run "hcid" daemon... I 
could not
find a man page... Then when I was beginning to use hcid it gave error
that it could not execute pin helper, so I fixed the path to 
executable file
that generates my selected PIN code. When I manually execute the pin_
helper
file, it outputs 4 digits to the console, which is my test PIN. It is 
executable.

Anyway, now I run hcid before my testing procedure.

At this point, here is my situation:

1. Prepare phone: Set bluetooth ON (not discoverable, by now I know 
the
MAC address!), then choose Linked Devices->Add Device->Phone Accepts.
Phone says "Ready to Pair"

2. Prepare PC: bluetooth card inserted, then do "cardctl insert", and 
verify
messages on /var/log/messages (hcid reports HCI dev 0 registered, hci
dev 0 up, then Starting security manager 0.)

3. Execute script:

    hciconfig hci0 up
    hciconfig hci0 auth 3 (per Marcel suggestion)
    rfcomm bind 0 MAC-ADDRESS 1 (note I changed parameter #2 to 0, 
not /dev/rfcomm0)
    ---> reports "rfcomm0: MAC-ADDRESS channel 1 clean"
    cat </dev/rfcomm0

4. At this point the computer device name (from hcid.conf) appears on 
the phone,
and the phone says "Add to paired devices?" I select Yes. I enter my 
PIN digits
(as configured in pin helper script file) and phone says "Pairing 
failed, Retry?"

5. The cat command reports:  "Warning: null TTY for (d8:00) in tty_
fasync" and
"-bash: /dev/rfcomm0: Permission denied"

6. At this point I went back to /var/log/messages and I see these 
messages in
the file:

kernel: application bug: hcid(PID) has SIGCHLD set to SIG_IGN but 
calls wait()
kernel: (see the NOTES section of 'man 2 wait'). Workaround activated.
kernel: Warning: null TTY for (d8:00) in tty_fasync.

As an alternative, I tried using l2ping instead of cat </dev/rfcomm0 
to get the
security routine to start. l2ping reported the error message "Can't 
connect: Permission denied"
and /var/log/messages included two of the same kernel messages (
application bug
about wait) but not the message about null TTY.

My question: What should I do to start the security sequence?

Should I update hcid (I am now using version 2.2 as reported by hcid -?)

I hope I can make more progress without installing a new kernel, 
because I searched
for RPM for later kernel in 2.4 series (I am now using 2.4.20-31.9) 
but there is no
later version RPM, and my machine does not set up with compiler, so I 
cannot try
to compile new kernel.

Dave
wb0gaz@hotmail.com


###


>> So my core question - how do I complete the pairing process, when 
>> initiated
>> by the PC and accepted by the phone?
>
>The phone uses security level 2 and this means the security routines
>kick in when you request access to the RFCOMM channel. If you want them
>earlier then the use of security mode 3 is needed. Use "hciconfig hci0
>auth" to activate it on your device.
>
>Regards
>
>Marcel
