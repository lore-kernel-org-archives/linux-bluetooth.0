Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
References: <5B7F662D.5010903@mail.zabtrans.ru> <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Aug 2018 17:36:12 +0300
Message-ID: <CABBYNZ+7MkWgS9ML0q58axM37m-PzW5jMDy6x1Q_TUWWU86V7g@mail.gmail.com>
Subject: Re: Problem with StopDiscovery() via dbus-send
To: ProklovAV@mail.zabtrans.ru
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Aug 24, 2018 at 11:19 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Aug 24, 2018 at 4:58 AM, =D0=9F=D1=80=D0=BE=D0=BA=D0=BB=D0=BE=D0=
=B2 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=92=D0=B0=D0=
=BB=D0=B5=D1=80=D1=8C=D0=B5=D0=B2=D0=B8=D1=87
> <ProklovAV@mail.zabtrans.ru> wrote:
>>  Hello All,
>>
>> Thanks for your work. Since version bluez-5.50 start-stop discovery work
>> from command line and scripts:
>> #bluetoothctl scan on
>> #bluetoothctl scan off
>> (see mail-list "Problem with StopDiscovery() via dbus-send")
>>
>> --------------------------------------------
>>
>> My next task is to do pair with device from bash script. I tried several
>> ways:
>> 1. #bluetoothctl pair 11:22:33:44:55:66 does not work because the agent =
is
>> not created.
>> 2. Make  agent via Dbus:
>> #dbus-send --system --print-reply --type=3Dmethod_call --dest=3Dorg.blue=
z
>> /org/bluez org.bluez.AgentManager1.RegisterAgent objpath:/org/bluez/agen=
t1
>> string:KeyboardOnly
>> the command works, but I do not see in Dbus /org/bluez/agent1 created.
>> 3. Make agent via bluetoothctl:
>> [bluetooth]#agent on
>> the command works, but I do not see in Dbus agent path!.
>
> Im not sure Im following, you would like to have non-interactive mode
> working for bluetoothctl pair? The point number 2 don't make much
> sense since dbus-send normally disconnected after the reply that means
> the agent would be gone, also regarding 3 if you use a more recent
> version of bluetootctl it registers and agent automatically nowadays.
>
>> May be possible to set a default pin code via /etc/bluetooth/main.conf
>> if it is available, do not make a request for a pin from the command lin=
e? I
>> think that then #bluetoothctl pair 11:22:33:44:55:66 will be able to wor=
k
>> fine.
>
> That is something I had in mind, lets see if I can come up with something=
.

Actually it doesn't seems to be possible with the current IO
capabilities even if I set KeyboardOnly the phone end up displaying
the passcode on its end, so it seems there is no combination where the
acceptor would be asked to enter a passkey and the initiator to enter
it. I wonder if that is on purpose though, because right now the only
options in case of headless solution would be to use just works and
switch Adapter.Pairable on demand.

--=20
Luiz Augusto von Dentz
