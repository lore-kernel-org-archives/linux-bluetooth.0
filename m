Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273257547.1912.10.camel@mosquito>
References: <201005071302.36198.jcaden@libresoft.es> <20100507120859.GD12461@vigoh>
	<k2taa32413d1005071125ob7ce6505q8bb2cc57a77f1c8f@mail.gmail.com>
	<1273257547.1912.10.camel@mosquito>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Fri, 7 May 2010 15:49:46 -0300
Message-ID: <p2oaa32413d1005071149i135939d2m89a7e78de71ec568@mail.gmail.com>
Subject: Re: Data transmission and reconnections in HDP
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: =?UTF-8?Q?Jos=C3=A9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Santiago!

2010/5/7 Santiago Carot-Nemesio <scarot@libresoft.es>:
> Hi João Paul,
>
> El vie, 07-05-2010 a las 15:25 -0300, João Paulo Rechi Vita escribió:
>> Hello Jose!
>>
>> On Fri, May 7, 2010 at 09:08, Gustavo F. Padovan <gustavo@padovan.org> wrote:
>> > Hi José,
>> >
>> > * José Antonio Santos Cadenas <jcaden@libresoft.es> [2010-05-07 13:02:36 +0200]:
>> >
>> >> Hi all,
>> >>
>> >> I start this thread to discuss the alternatives to move the data from the
>> >> application to the l2cap socket in HDP. Till now we have the following
>> >> alternatives (please, add more if we missed something)
>> >>
>> >> Reconnections options:
>> >>
>> >>  Option 1: Implicit reconnections: The application is not concern about the
>> >> disconnections or reconnections of the data channel until it is deleted.
>> >>
>> >>       We prefer this option because fixes more with a manager philosophy. A
>> >> 20601 manager sould not perceive temporal disconnections because this way can
>> >> hold it state if it perceives a disconnection, next time it reconnects it will
>> >> need to exchange again apdus for association.
>> >>
>> >>  Option 2: Reconnections by the application. The applications are notified when
>> >> a data channel is disconnected and should perform a reconnection before using
>> >> it again.
>> >>
>>
>> The HDP Implementation Guidance Whitepaper clearly states that
>> transport (HDP) disconnection / reconnection should be transparent for
>> the data layer (IEEE 11073-20601), so I guess option 2 here would
>> break the spec.
>
> You're rigth, we consider that option 1 is the best approach. But it's
> better try get consensus ;)
> In addition, option 2 pass MCAP logic to application layer
> (connection-reconnection), and 11073-20601 should be independent of such
> transport specific characteristics.
>

My main concern here is not about which one is the best approach, but
about specification-compliance. Sometimes we may want to deviate a bit
from the spec if this provides a big performance gain or so, but it
has to be evaluated with much caution, since it can compromise
qualification with the Bluetooth SIG (on some cases for the whole
stack). I may have misread the spec and it might have left this
approach 2 as an option, so please correct me in this case. But if
not, I guess approach should not be considered.

-- 
João Paulo Rechi Vita
http://jprvita.wordpress.com/
