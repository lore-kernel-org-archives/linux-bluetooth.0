Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <877fpq5z3d.fsf@intel.com>
References: <CAPcThSGd9RO=8aK0ALkyWzSa7zLpr=8o7qMpT5sNex=LWu_XtQ@mail.gmail.com>
	<CABBYNZLLd-dS0u39roqCrin=MpYy7WNiL4MEYDik0o-0G84JDA@mail.gmail.com>
	<CAPcThSHpPpV8f=WeEEFySrWP9sHCfzqs+n5U+n+=wohwg0=g-g@mail.gmail.com>
	<877fpq5z3d.fsf@intel.com>
Date: Fri, 24 Jul 2015 09:40:38 +1000
Message-ID: <CAPcThSHxq_Ax23H0VuqQF6z+7GoXHTL8L5RdL_jg5pjv2Q_mkQ@mail.gmail.com>
Subject: Re: How to write a C program to be paired asynchronously?
From: Qingtao Cao <qingtao.cao.au@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Vinicius,

Many thanks for your kind reply!

Well, I am using the latest Ubuntu 15.04 and bluez-4.101 is its
supported bluez version that's why I am using it :-)

As for the trick to set agent_path as "/", well, I did more test and
it didn't seem to make a difference than a more specific one such as
"/test/bluez/agent_<pid>". Firstly I will always register an object to
the agent_path with the interface supported, then what really matters
is whether to RegisterAdapter such agent_path or not.

For outgoing pairing requests (actively pairing another remote device
from my program), if such object path is registered via
RegisterAdapter, then dbus-monitor reveals no message emitted from
org.bluez sender at all. Only when the step to invoke RegisterAdapter
is skipped over, will the RequestConfirmation callback is called to
generate a random pincode to be sent to the remote device for
confirmation.

For incoming pairing requests (being paired by remote devices), if
such object path is registered via RegisterAdapter, then could
RequestConfirmation be invoked. Otherwise, strangely, the pairing
requests initiated from remote device will always be silently and
automatically accepted, without RequestConfirmation being invoked at
all, nor will the remote device popped out some dialogue message to
ask for confirmation.

BTW, the test/agent.c in bluez-4.101 source seems to adopt the same
logic as abstracted below:

    if (device) {
        if (create_paired_device(conn, adapter_path, agent_path,
                        capabilities, device) < 0) {
            dbus_connection_unref(conn);
            exit(1);
        }
    } else {
        if (register_agent(conn, adapter_path, agent_path,
                            capabilities) < 0) {
            dbus_connection_unref(conn);
            exit(1);
        }
    }

Where device is the parameter of the remote device to pair with, that
is to say, register_agent() is only invoked for incoming pairing
requests but skipped over for outgoing pairing attempts.

Lastly, as for your suggestion to capability, you are right that
bluez-simple-agent has manipulated KeyboardDisplay capability and all
possible callbacks used by bluez so as to pair with all sorts of
devices.

Thanks again!

Harry


On Fri, Jul 24, 2015 at 7:43 AM, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
> Hi Harry,
>
> Qingtao Cao <qingtao.cao.au@gmail.com> writes:
>
>> Hi Luiz,
>>
>> Many thanks for your comments! I sure will try to navigate through the
>> source code to find a concrete answer.
>>
>> I did some progress today but had a further related question about the
>> agent in the pairing process.
>>
>> Previously I have manipulated bluez's dbus APIs to pair a given remote
>> device successfully, turns out before invoking the
>> CreatePairedDevice() method on the org.bluez.Adapter interface, I only
>> need to register the handler of the RequestConfirmation() message on
>> the org.bluez.Agent interface (although no object existed to register
>> it in the first place) to reply an empty reply and the pairing attempt
>> launched by remote device can succeed.
>>
>> Later today I found that in order to handle async pairing request from
>> remote device successfully, aside from the handler of the same
>> RequestConfirmation() message, the missing piece seems to be using the
>> RegisterAgent() method on the org.bluez.Adapter interface, without
>> which the bluetoothd seems won't throw out the RequestConfirmation()
>> message at all.
>>
>> Now what puzzles me is that if I register an agent before invoking the
>> CreatePairedDevice() method and passing it the discretionary object
>> path of the agent registered,  the RequestConfirmation() won't be
>> called at all in the first scenario. Also the doc/adapter-api.txt says
>> that during CreatePairedDevice() invocation it's not necessary to
>> register an agent, but it didn't prohibit it. By contrast, an agent
>> would have to be registered in the second scenario.
>
> If you pass "/" as the agent path to CreatePairedDevice() it should use
> the agent that was registered for that Adapter.
>
> (You are asking about BlueZ 4.XX, which was released some time ago, I
> may have forgotten how it used to work ;-)
>
>>
>> So, how should I use an agent consistently regardless of whether it is
>> incoming or outgoing pairing request?
>
> That "/" trick should do the job.
>
>>
>> Moreover, different agent capability such as KeyboardDisplay or
>> NoInputNoOutput will make a difference in terms of agent APIs invoked
>> by bluetoothd during pairing, how should I assign a proper capability
>> for my agent, if needed, for different devices such as mobile, headset
>> or keyboard?
>
> Usually you don't have all the information necessary at the point when
> CreatePairedDevice() to choose, only when the bonding procedure is started,
> and both devices exchange their capabilities you have that kind of
> information. So, my suggestion is, implement all the callbacks, so you
> can pair with all kinds of devices, inform the most sofisticated
> capability and leave the kernel to do the negotiation.
>
>
> Cheers,
> --
> Vinicius
