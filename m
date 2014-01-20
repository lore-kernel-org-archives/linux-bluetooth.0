Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <06DCDA5B-0724-489D-8039-1CD8E8CC62E8@holtmann.org>
References: <CAHrH25SjO5Bgdjnu6YjwKSQEiwvP+p8bfqcjJO9WEMDvG1A3PQ@mail.gmail.com>
	<06DCDA5B-0724-489D-8039-1CD8E8CC62E8@holtmann.org>
Date: Mon, 20 Jan 2014 14:54:34 -0200
Message-ID: <CAKT1EBe9ZJb3q0DqsUOKqynCV=Kb5euUE8S5vy1kM+1+2+Cu+w@mail.gmail.com>
Subject: Re: Status of BlueZ GATT APIs
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@google.com>,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>, Andre Guedes <andre.guedes@openbossa.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman/Marcel:

On Sat, Jan 18, 2014 at 5:42 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arman,
>
>> I was wondering what the current plans are for the GATT D-Bus API in
>> BlueZ. Can anyone give a rough estimate of when these APIs will be
>> available in BlueZ upstream and approximately when they could make to
>> into a release?
>
> I think the best person to answer this is Claudio. INdT has been working =
on these patches and we have discussed the APIs during the Plumbers Conf.
>
> Maybe they just need to re-submit a new version and we could include them=
. I honestly don=E2=80=99t know until I see an updated set of the patches.
>
> Regards
>
> Marcel

Ok. I will rebase and re-submit the patchset "[PATCH BlueZ v0 00/18]
GATT API: External Services".

Considering that some groups are interested in the GATT API again we
can start a task force to upstream the code that we have.

IMO, the GATT Server API will be more simple to upstream. We can keep
a completely separated implementation using unix socket to avoid
breaking the current implementation, and switch to the new attribute
server when we achieve a common sense.

However, before starting the Client implementation, the kernel patches
related connection and scanning sent from Andre are essential to have
a stable implementation. The GATT Client implementation needs to be
re-written from scratch, our old code was based on another "auto
connect" kernel patch approach.

Roughly speaking, our up-streaming plan is:
* GATT Server: External Services =3D> "[PATCH BlueZ v0 00/18] GATT API:
External Services"
* GATT Server: External Characteristics (Server) =3D> Ready to be submitted
* GATT Server: External Descriptors (Server) =3D> Copy from our old branch
* Replace attribute server
* Client:  Remove ATTIO and automatic connection mechanism from
userspace =3D> Requires kernel patches
* Client: Fix all GATT internal plugins
* Client: Remote Services API
* ...

Regards,
Claudio
