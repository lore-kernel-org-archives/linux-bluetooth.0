Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386874657-26642-1-git-send-email-luiz.dentz@gmail.com>
References: <1386874657-26642-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 13 Dec 2013 11:23:13 -0200
Message-ID: <CAJdJm_OLnBVBR_qNxjTYE3G+RG8KRhobGjWXcfTom9xZu0c=-g@mail.gmail.com>
Subject: Re: [RFC v2 BlueZ] build: Add coverage support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Dec 12, 2013 at 4:57 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> +clean-local: clean-coverage
> +       @find $(top_builddir) -name "*.gcda" -exec $(RM) {} \;
> +       @find $(top_builddir) -name "*.gcno" -exec $(RM) {} \;

Another simplification suggestion:  Replace " -exec $(RM) {} \;" with
"-delete", e.g.:

@find $(top_builddir) -name "*.gcda" -delete

BTW if the deletion fails (e.g. file was created as root but cleanup
is done as non-root), the find command will fail. If it is desirable
that the cleanup never fail, you may need to add a "-" before the
command (or use "|| true", whatever is the convention in BlueZ).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
