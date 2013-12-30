Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1388398647-25420-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1388398647-25420-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1388398647-25420-5-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 30 Dec 2013 13:25:55 +0200
Message-ID: <CABBYNZJhLpuzQzodYqXYTPHO0G70xvKiWUAgOqjMFf2OBhhZtQ@mail.gmail.com>
Subject: Re: [RFC 4/6] android: Keep stream_out example in the API doc
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Dec 30, 2013 at 12:17 PM, Lukasz Rymanowski
<lukasz.rymanowski@tieto.com> wrote:
> ---
>  android/audio-ipc-api.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
> index 5140d77..c2d23d9 100644
> --- a/android/audio-ipc-api.txt
> +++ b/android/audio-ipc-api.txt
> @@ -27,11 +27,11 @@ HAL socket apply here as well, the abstract socket name is
>         call dev->open_output_stream()      --> command 0x03
>         return dev->open_output_stream()    <-- response 0x03
>
> -       call stream_in->read()              --> command 0x05
> -       return stream_in->read()            <-- response 0x05
> +       call stream_out->write()            --> command 0x05
> +       return stream_out->write()          <-- response 0x05
>
> -       call stream_in->common.standby()    --> command 0x06
> -       return  stream_in->common.standby() <-- response 0x06
> +       call stream_out->common.standby()   --> command 0x06
> +       return stream_out->common.standby() <-- response 0x06
>
>         call dev->close_output_stream()     --> command 0x04
>         return dev->close_output_stream()   <-- response 0x04
> @@ -39,6 +39,8 @@ HAL socket apply here as well, the abstract socket name is
>         call dev->close()                   --> command 0x02
>         return dev->close()                 <-- response 0x02
>
> +Note: Similar applies to stream in scenario.
> +
>  Identifier: "audio" (BT_AUDIO_ID)
>
>         Opcode 0x00 - Error response
> --
> 1.8.4

I would leave it as just stream, so it should work regardless of the direction.


-- 
Luiz Augusto von Dentz
