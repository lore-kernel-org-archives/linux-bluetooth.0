Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACbkbU+i7peciUG-pynE+ApDxDq5XL18W=CaD1utYCyKRO0+_w@mail.gmail.com>
References: <CACbkbU+i7peciUG-pynE+ApDxDq5XL18W=CaD1utYCyKRO0+_w@mail.gmail.com>
Date: Wed, 28 Sep 2011 08:41:30 -0400
Message-ID: <CAJdJm_MK45U54eP0j0rGg7rO0aCJjBR0pvVxHxC8VgJC6sA6Jg@mail.gmail.com>
Subject: Re: [RFC] Need to unref and free user data in gatt_find_info for plen
 0 case
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: VISHWANATH KM <a21174@motorola.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 28, 2011 at 2:57 AM, VISHWANATH KM <a21174@motorola.com> wrote:
> 1. In gatt_find_info if start handle > end handle , then still we
> issue ATT_Find_Info_Req and receive response from remote device as
> invalid handle, its ok though from spec point of view but however its
> an overhead which can be reduced with below check.

I think this check should be done by the caller of gatt_find_info().
This way, it can pass the correct error to higher layers (i.e. error
message to user). The functions in gatt.c are supposed to be thin
layers around the enconde/decode functions from att.c.

> 2. In gatt_find_info with plen 0, it needs unref and freeing user_data
> as the descriptor_cb won't be triggered in this case, and there will
> be a reference count mismatch.
> below change takes care of both,
>
> -        if (plen == 0)
> +       if (plen == 0 || start > end) {
> +               g_attrib_unref(attrib);
> +               g_free(user_data);
>                 return 0;
> +       }

I also think this should be done by the caller of gatt_find_info(),
because it know better when to release the attrib reference. Also note
that you are assuming user_data is always dynamically allocated with
g_* functions, which is not guaranteed (user_data is a opaque
pointer).

Ideally, the caller of gatt_find_info() should:

1) check for correct parameters before calling the function
2) check for return value equal to zero and free the resources.

My two cents,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
